set ns [new Simulator]
set tf [open p1a.tr w]
$ns trace-all $tf
set nf [open p1a.nam w]
$ns namtrace-all $nf

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]

$n0 label "source"
$n1 label "router"
$n2 label "destination"

$ns color 1 "blue"

$ns duplex-link $n0 $n1 200Mb 300ms DropTail
$ns duplex-link $n1 $n2 1Mb 100ms DropTail

$ns queue-limit $n0 $n1 10
$ns queue-limit $n1 $n2 2

set udp0 [new Agent/UDP]
$ns attach-agent $n0 $udp0
set cbr0 [new Application/Traffic/CBR]
$cbr0 attach-agent $udp0

set null0 [new Agent/Null]
$ns attach-agent $n2 $null0

$udp0 set class_ 1

$ns connect $udp0 $null0

$cbr0 set packetSize_ 500Mb
$cbr0 set interval_ 0.001

proc finish { } {
    global ns nf tf
    $ns flush-trace
    close $tf
    close $nf
    exec nam p1a.nam &
    exit 0
}

$ns at 0.1 "$cbr0 start"
$ns at 5.0 "finish"
$ns run