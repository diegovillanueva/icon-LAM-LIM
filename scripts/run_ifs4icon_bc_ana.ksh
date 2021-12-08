#!/bin/ksh
#SBATCH --partition=batch_long

start_hour=06

#date_in='2020-01-21'
#ndays=23

date_in='2020-02-02'
ndays=12

day_dir=`date -d "${date_in}" '+%Y%m%d'`
day_dir="EURECHA_ana"

idir=$(pwd)
mkdir -p $SCRATCH/ifs_icon/${day_dir}

cd $SCRATCH/ifs_icon/${day_dir}

echo $idir
echo $SCRATCH/ifs_icon/${day_dir}

initialHour=0
finalHour=$(($start_hour+24*$ndays))

for s in `seq $initialHour 3 $finalHour`
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

/home/ms/datex/gdr/scripts_diego/icon/mars4icon/mars4icon_smi_new -r 1279 -l 1/to/137 -d ${year}-${month}-${day}T${hour} -s 0 -O -L 15 -o ana_${year_name}${month_name}${day_name}_T${hour_name}.grb -p 10 &> ana_${year}-${month}-${day}T${hour}.err

echo $(pwd)/ana_${year}-${month}-${day}T${hour}.err

done
exit


