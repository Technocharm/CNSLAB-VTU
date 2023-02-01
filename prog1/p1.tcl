set ns [new Simulator]
set tf [open p1.tr w]
$ns trace-all $tf
set nf [open p1.nam w]
$ns namtrace-all $nf

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]

$n0 label "source"
$n1 label "router"
$n2 label "destination"

$ns color 1 "blue"

$ns duplex-link $n0 $n1 100Mb 300ms DropTail
$ns duplex-link $n1 $n2 1Mb 100ms DropTail

$ns queue-limit $n0 $n1 10
$ns queue-limit $n1 $n2 2

set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0
set sink1 [new Agent/TCPSink]
$ns attach-agent $n2 $sink1

$tcp0 set class_ 1

$ns connect $tcp0 $sink1
$tcp0 set packetSize_ 500Mb
$tcp0 set interval_ 0.001 

set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0

proc finish { } {
    global ns nf tf
    $ns flush-trace
    close $tf
    close $nf
    exec nam p1.nam &
    exit 0
}

$ns at 0.1 "$ftp0 start"
$ns at 5.0 "finish"
$ns run