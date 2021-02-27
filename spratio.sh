#!/bin/sh
# this script generate two station spectral ratio 
ls sm*
echo "enter file1 and file2"
read f1 f2

stn1=`echo "$f1" | awk '{s=substr($1,1,3); print s}'`
stn2=`echo "$f2" | awk '{s=substr($1,1,3); print s}'`

echo "output file is ${stn1}.${stn2}"
del1=`sac <<! | grep "DIST" | awk '{printf "%10.2f \n",$3}'
r $f1  
lh DIST
!`
echo "del1 = $del1"

del2=`sac <<! | grep "DIST" | awk '{printf "%10.2f \n",$3}' 
r $f2  
lh DIST
!`
echo "del2 = $del2"

stlat1=`sac <<! | grep "STLA" | awk '{printf "%10.2f \n",$3}' 
r $f1  
lh STLA
!`

stlog1=`sac <<! | grep "STLO" | awk '{printf "%10.2f \n",$3}' 
r $f1  
lh STLO
!`
echo "stlat1 = $stlat1 stlog1 = $stlog1"

stlat2=`sac <<! | grep "STLA" | awk '{printf "%10.2f \n",$3}' 
r $f2  
lh STLA
!`

stlog2=`sac <<! | grep "STLO" | awk '{printf "%10.2f \n",$3}' 
r $f2  
lh STLO
!`
echo "stlat2 = $stlat2 stlog2 = $stlog2"


del=`echo "distaz $stlat1 $stlog1 $stlat2 $stlog2 " | sh | awk '{print $1}'`
echo "del = $del"

del12=`(echo "scale = 3; $del * 111.3131" | bc)`
echo "del12 = $del12"

echo "r $f1 $f2" > sac.macs
echo "color on increment on" >> sac.macs
echo "xlim 0 5" >> sac.macs
echo "plot2 " >> sac.macs
echo 'cut on $cutonvalues ' >> sac.macs
echo "r $f1 $f2 " >> sac.macs
echo "w temp1 temp2 " >> sac.macs
echo 'r temp1 ' >> sac.macs
echo 'divf temp2 ' >> sac.macs
echo "evaluate to x $del1 / $del2 " >> sac.macs
echo "evaluate to z (sqrt %x ) " >> sac.macs
echo "mul %z  " >> sac.macs
echo "log " >> sac.macs
echo "evaluate to y 3.5 / 3.14 / $del12 " >> sac.macs
echo "mul %y " >> sac.macs
echo "w ${stn1}.${stn2} " >> sac.macs
echo "cut off " >> sac.macs
echo "convert from sac ${stn1}.${stn2} over alpha " >> sac.macs
echo "sc rm -f temp1 temp2" >> sac.macs
echo "inicm " >> sac.macs
echo "quit" >> sac.macs

sac sac.macs

rm -f sac.macs






