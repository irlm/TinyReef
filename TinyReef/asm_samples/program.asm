load  $0, var0
loadc $1, 1
add  $0, $1, $2
store $2, var0
led  $2
halt

event $Booted, Booted
event $, Blah

Booted:
...
...
...
Timer1.StartPeriodic(1000)
Timer2.StartPeriodic(2000)
halt

Blah:
MovRM $0, [0]
AddC $0 1
MovMR [0], $0
led $0
halt 

//----------------- add 2
//a := b + c
//var0 na memoria
//b = 3
//c = 4

MovC $1 "3"
MovC $2 "4"
Add $0 $1 $2
MovM $0 "var"
