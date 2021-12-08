#!/bin/ksh
#SBATCH --partition=batch_long

start_hour=12
date_in='2020-01-21'
ndays=23
day_dir=`date -d "${date_in}" '+%Y%m%d'`

mkdir -p $SCRATCH/ifs_icon/${day_dir}

cd $SCRATCH/ifs_icon/${day_dir}

finalHour=$(($start_hour+24*$ndays))

for s in `seq 0 3 $finalHour`
do
    let  hs=$s+${start_hour}
    let  hs_name=$s+${start_hour}
    hour=$(date -d "${date_in} ${hs} hour" +'%H')
    day=$(date -d "${date_in} ${hs} hour" +'%d')
    month=$(date -d "${date_in} ${hs} hour" +'%m')
    year=$(date -d "${date_in} ${hs} hour" +'%Y')

    hour_name=$(date -d "${date_in} ${hs_name} hour" +'%H')
    day_name=$(date -d "${date_in} ${hs_name} hour" +'%d')
    month_name=$(date -d "${date_in} ${hs_name} hour" +'%m')
    year_name=$(date -d "${date_in} ${hs_name} hour" +'%Y')


echo    /home/ms/datex/gdr/scripts_diego/icon/mars4icon/mars4icon_smi_new -r 1279 -l 1/to/137 -d ${year}-${month}-${day}T${hour} -s 3 -O -L 15 -o ${year_name}${month_name}${day_name}_T${hour_name}.grb -p 10

done
exit


