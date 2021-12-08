#use as: sh regrid.sh icon_lam_1dom_EURECHA_1w/2d_cloud_DOM01_ML_20200121T120000Z.nc

first_file_to_regrid_full=$1
first_file_to_regrid=$(basename $first_file_to_regrid_full)
dirname=$(dirname $first_file_to_regrid_full)

#DOM=${DOM:-01}
DOM=${first_file_to_regrid%_ML_*}
DOM=${DOM#*_DOM}


gridfile_full=$dirname/domain${DOM/0/}_DOM${DOM}.nc #wont work because of vertex dimension
gridfile=$(basename $gridfile_full)


cd $dirname

	#get rid of vertex dimension
	cdo -O -selname,clon,clat,cell_area,lon_cell_centre,lat_cell_centre,edge_of_cell,vertex_of_cell,cell_area_p,orientation_of_normal,clon_vertices,clat_vertices,parent_cell_index,neighbor_cell_index,refin_c_ctrl \
		{,cell.}${gridfile}

	gridfile=cell.${gridfile}

# cdo grid description file for global regular grid of ICON.
# use python grid_details.py
cat > target_grid.txt << REMAP_TARGET_FILE
gridtype = lonlat
xsize    = 600
ysize    = 500
xfirst   = -62
xinc     = 0.02
yfirst   = 8
yinc     = 0.02
REMAP_TARGET_FILE

	#create weights
	cdo gennn,target_grid.txt $gridfile weights.${first_file_to_regrid}

	#test grid size
	echo ncdump -h $dirname/weights.${first_file_to_regrid} "| head"
	echo ncdump -h $dirname/$gridfile "| head"
	echo ncdump -h $dirname/$first_file_to_regrid "| head"

	mkdir -p mergetime_clm_DOM$DOM/split
	mkdir -p mergetime_clm_DOM$DOM/split_ts

	#main loop
	ipid=0
	regridded_files=()
	for file_to_regrid_full in $@ ; do

		file_to_regrid=$(basename $file_to_regrid_full)

		regridded_file=regridded.${file_to_regrid}
		regridded_files=(${regridded_files[@]} $regridded_file)

		(

		cdo -O -expr,'cloud_mask_low=clcl>50' {,clm.}$file_to_regrid

		cdo -f nc remap,target_grid.txt,weights.${first_file_to_regrid} \
				clm.$file_to_regrid \
				$regridded_file

		cdo splitsel,1 $regridded_file mergetime_clm_DOM$DOM/split/${regridded_file}


		) & pids[${ipid}]=$! ; ipid=$(expr $ipid + 1)

	done
	for eachPid in ${pids[*]}; do wait $eachPid; done

	for f in mergetime_clm_DOM$DOM/split/*.nc ; do
		(
		ts=$(cdo showtimestamp $f)
		ts=${ts// /}
		ts=${ts//:/}
		/bin/mv $f mergetime_clm_DOM$DOM/split_ts/clm_DOM${DOM}_$ts.nc 
		echo $dirname/mergetime_clm_DOM$DOM/split_ts/clm_DOM${DOM}_$ts.nc
		) & pids[${ipid}]=$! ; ipid=$(expr $ipid + 1)
	done
	for eachPid in ${pids[*]}; do wait $eachPid; done
	
	mkdir -p mergetime_clm_DOM$DOM/mergetime
	cdo -O mergetime mergetime_clm_DOM$DOM/split_ts/clm_DOM${DOM}_*.nc mergetime_clm_DOM$DOM/mergetime/clm_DOM${DOM}.nc &
	echo mergetime_clm_DOM$DOM/mergetime/clm_DOM${DOM}.nc

