#!/bin/sh
# to cut event with velocity window

for event in `ls *.BHZ`
do

otime=`sac<<! | grep "OMARKER" | awk '{print $3}'
r $event
lh OMARKER
!`
echo "Origin time = $otime"

dist=`sac<<! | grep "DIST" | awk '{printf "%8.2f ",$3}'
r $event
lh DIST
!`
echo "Distance = $dist"

Stime=`(echo "($dist/3.6) + $otime " | bc)`
Etime=`(echo "($dist/2.8) + $otime " | bc)`
echo "Cut time is $Stime and $Etime"



echo "r $event" > sac.macs
echo "rmean" >> sac.macs
echo "rtr" >> sac.macs
echo "qdp off" >> sac.macs
echo "bp co 0.5 5.0 p 2 n 4" >> sac.macs
echo "cut B $Stime $Etime" >> sac.macs
echo "r" >> sac.macs
echo "taper" >> sac.macs
echo "w ${event}_Lg" >> sac.macs
echo "cut off" >> sac.macs
echo "quit" >> sac.macs

sac sac.macs
rm -f sac.macs

done

