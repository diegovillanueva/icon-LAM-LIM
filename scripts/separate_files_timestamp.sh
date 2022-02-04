#example how to split nc file into timesteps and rename after timestamp
splitTimeStepNC(){
        mkdir -p $2
        cdo -O splitsel,1 $1 $2
}
RenameAfterTimeStamp(){
        f=$1
        ts=$(cdo showtimestamp $f)
	echo $ts
        ts=$(echo $ts | xargs)
	echo $ts
        ts=$(echo "$ts" | sed "s/://g")
	echo $ts
        /bin/mv $f $(dirname $f)/${ts}.nc
}

#for file in $(find Low_level_mask/ -name "*.nc") ; do
for file in $(find Low_level_mask/4km_0.02deg.clcl_mask/ -name "*.nc") ; do
	splited_directory=single_Timestep_$(dirname $file)
	mkdir -p $splited_directory

	#split
	splitTimeStepNC $file $splited_directory/split

	echo $splited_directory/
	for timestep_file in $splited_directory/split*.nc ; do
		echo $timestep_file
		#rename
		RenameAfterTimeStamp $timestep_file
	done
done
