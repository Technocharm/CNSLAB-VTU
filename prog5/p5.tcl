set val(type) GSM
set ns [new Simulator]
set tf [open p5.tr w]
$ns trace-all $tf
set nf [open p5.nam w]
$ns namtrace-all-wireless $nf 1000 1000
set df [open delay.tr w]
set thf [open throughput.tr w]
set lf [open lost.tr w]

set topo [new Topography]
$topo load_flatgrid 1000 1000

$ns node-config -adhocRouting AODV\
    -llType LL\
    -macType Mac/802_11\
    -phyType Phy/WirelessPhy\
    -channelType Channel/WirelessChannel\
    -antType Antenna/OmniAntenna\
    -propType Propagation/TwoRayGround\
    -topoInstance $topo\
    -ifqType Queue/DropTail/PriQueue\
    -ifqLen 1000\
    -routerTrace ON\
    -agentTrace ON\
    -macTrace OFF\
    -energyModel EnergyModel\
    -initialEnergy 100\
    -rxPower 0.3\
    -txPower 0.6 

create-god 25

for {set i 0} {$i < 25} {incr i} {
    set node($i) [$ns node]
    $node($i) set X_ [expr rand()*1000]
    $node($i) set Y_ [expr rand()*1000]
    $node($i) set Z_ 0
}

for {set i 0} {$i < 25} {incr i} {
    set xx [expr rand()*1000]
    set yy [expr rand()*1000]
    $ns at 0.5 "$node($i) setdest $xx $yy 200"
}

for {set i 0} {$i < 25} {incr i} {
    $ns initial_node_pos $node($i) 100
}

set udp0 [new Agent/UDP]
$ns attach-agent $node(4) $udp0
set sink [new Agent/LossMonitor]
$ns attach-agent $node(20) $sink
set cbr0 [new Application/Traffic/CBR]
$cbr0 attach-agent $udp0
$ns connect $udp0 $sink

set hbytes 0
set hlpktt 0
set hpkt 0

proc record { } {
    global ns lf df thf hbytes hlpktt hpkt sink
    set time 0.5
    set now [$ns now]
    set bytes [$sink set bytes_]
    set nlost [$sink set nlost_]
    set lpt [$sink set lastPktTime_]
    set npkt [$sink set npkts_]
    
    puts $thf "$now [expr ($bytes+$hbytes)*8/(2*$time*1000000)]"
    puts $lf "$now [expr ($nlost)/$time]"

    if {$npkt > $hpkt} {
        puts $df "$now [expr ($lpt-$hlpktt)/($npkt-$hpkt)]"
    } else {
        puts $df "$now [expr ($hpkt-$npkt)]"
    }

    $sink set bytes_ 0
    $sink set nlost_ 0

    set hbytes $bytes
    set hlpktt $lpt
    set hpkt $npkt

    $ns at [expr $now+$time] "record"
}

$ns at 0.1 "$node(4) add-mark m red square"
$ns at 0.1 "$node(20) add-mark m orange square"

$ns at 0.1 "$node(4) label Sender"
$ns at 0.1 "$node(20) label Reciever"

proc finish { } {
    global ns tf nf df thf lf
    $ns flush-trace
    close $tf
    close $df
    close $thf
    close $lf
    exec nam p5.nam &
    exit 0
}

$ns at 0.0 "record"
$ns at 0.0 "$cbr0 start"
$ns at 5 "finish"
$ns run