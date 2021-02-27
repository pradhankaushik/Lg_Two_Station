#!/bin/bash

for file in `ls *.BHZ`
do
evla=`saclhdr -EVLA $file`
evlo=`saclhdr -EVLO $file`
stla=`saclhdr -STLA $file`
stlo=`saclhdr -STLO $file`
stn_name=`echo $file | awk -F "_" '{print $4}' | awk -F "." '{print $1}'`
echo $evlo $evla >>  events_cord.txt
echo $stlo $stla >> stations_cord.txt
echo $evlo $evla >> event_station.txt
echo $stlo $stla >> event_station.txt
echo $stlo $stla $stn_name >> long_lat_stn.txt

done

#plotting in GMT
grd_file=/home/SHARE/resources/GMT/GRD/INDIA_cont.grd
cpt_file=/home/SHARE/resources/GMT/CPT/india_colour.cpt

gmt grdimage $grd_file -C$cpt_file -R72/77/32/39 -JM10 -P -K -B1/2 > plot.ps
gmt psxy event_station.txt -R -JM -W1,black -P -O -A -K >> plot.ps
gmt psxy stations_cord.txt -R -JM -St0.6 -W0/0/0 -G0/0/255 -O -K >> plot.ps
gmt psxy events_cord.txt -R -JM -Sa0.6 -W0/0/0 -G255/0/0 -O -K >> plot.ps
gmt pstext long_lat_stn.txt -R -JM -F+f12p,Helvetica-Bold,red+a1+jLB -O >> plot.ps

rm gmt.history
rm *.txt
