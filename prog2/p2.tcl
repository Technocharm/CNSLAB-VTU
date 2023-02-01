set ns [new Simulator]
set tf [open p2.tr w]
$ns trace-all $tf
set nf [open p2.nam w]
$ns namtrace-all $nf

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]

$ns duplex-link $n0 $n2 200Mb 300ms DropTail
$ns duplex-link $n2 $n4 2Mb 100ms DropTail
$ns duplex-link $n5 $n2 200Mb 300ms DropTail
$ns duplex-link $n2 $n6 2Mb 100ms DropTail
$ns duplex-link $n3 $n2 200Mb 300ms DropTail
$ns duplex-link $n2 $n1 2Mb 100ms DropTail

$ns queue-limit $n0 $n2 10
$ns queue-limit $n2 $n4 2
$ns queue-limit $n5 $n2 10
$ns queue-limit $n2 $n6 2
$ns queue-limit $n3 $n2 10
$ns queue-limit $n2 $n1 2

$ns color 1 "red"
$ns color 2 "blue"

$n0 label "ping1"
$n1 label "ping2"
$n2 label "router"
$n3 label "ping3"
$n4 label "ping4"
$n5 label "ping5"
$n6 label "ping6"

set ping1 [new Agent/Ping]
$ns attach-agent $n0 $ping1
set ping2 [new Agent/Ping]
$ns attach-agent $n1 $ping2
set ping3 [new Agent/Ping]
$ns attach-agent $n3 $ping3
set ping4 [new Agent/Ping]
$ns attach-agent $n4 $ping4
set ping5 [new Agent/Ping]
$ns attach-agent $n5 $ping5
set ping6 [new Agent/Ping]
$ns attach-agent $n6 $ping6

$ping1 set packetSize_ 500Mb
$ping1 set interval_ 0.001
$ping5 set packetSize_ 500Mb
$ping5 set interval_ 0.001
$ping3 set packetSize_ 500Mb
$ping3 set interval_ 0.001

$ns connect $ping1 $ping4 
$ns connect $ping3 $ping2
$ns connect $ping5 $ping6

$ping1 set class_ 1
$ping5 set class_ 2


Agent/Ping instproc recv {from rtt} {
    $self instvar node_
    puts "the node [$node_ id] received an reply from $from with round trip time of $rtt"
}

proc sendpingpkt { } {
    global ns ping1 ping3 ping5
    set intervalTime 0.001
    set now [$ns now]
    $ns at [expr $now+$intervalTime] "$ping1 send"
    $ns at [expr $now+$intervalTime] "$ping3 send"
    $ns at [expr $now+$intervalTime] "$ping5 send"
    $ns at [expr $now+$intervalTime] "sendpingpkt"
}

proc finish { } {
    global ns nf tf
    $ns flush-trace
    close $tf
    close $nf
    exec nam p2.nam &
    exit 0
}

$ns at 0.01 "sendpingpkt"
$ns at 5.0 "finish"
$ns run 