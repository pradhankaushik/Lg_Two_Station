#!/bin/sh
# this script calculate spectra and then smooth it.

for event in `ls *Lg`
do

echo "r $event " > sac.macs
echo "fft " >> sac.macs
echo "keepam" >> sac.macs
echo "smooth halfwidth 17" >> sac.macs
echo "w ${event}_sm" >> sac.macs
echo "quit" >> sac.macs

sac sac.macs
rm -f sac.macs

done


