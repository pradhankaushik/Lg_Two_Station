#!/bin/bash

cd /DATA/Lg_Work/EGU_2021/tomography/Q_Tomo/data_15_deg_tolerance/events/2018193194647/RMKT-SUND

del1=`saclhdr -DIST v_2018193194647_IK_SUND.BHZ`
stlat1=`saclhdr -STLA v_2018193194647_IK_SUND.BHZ`
stlog1=`saclhdr -STLO v_2018193194647_IK_SUND.BHZ`
del2=`saclhdr -DIST v_2018193194647_IK_RMKT.BHZ`
stlat2=`saclhdr -STLA v_2018193194647_IK_RMKT.BHZ`
stlog2=`saclhdr -STLO v_2018193194647_IK_RMKT.BHZ`

echo $del1 $del2

echo $stlat1 $stlog1 $stlat2 $stlog2


