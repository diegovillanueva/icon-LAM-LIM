source /home/b/b380602/.myfunctions.sh

#https://disc.gsfc.nasa.gov/datasets/GPM_IMERG_LandSeaMask_2/summary?keywords=imerg
slm=GPM_IMERG_LandSeaMask.2.nc4

f=$1

if false ; then #regrid slm
cp ../target_grid.txt  ./
cdo gennn,target_grid.txt $slm weights.nc
cdo -f nc remap,target_grid.txt,weights.nc \
	$slm \
	regrided.$slm
fi

nf=regrided.$slm
#flip lon lat in slm mask
ncpdq -O -a lat,lon regrided.$slm regrided.$slm

#add float of lat lon in all grid
ncap2 -O -s 'flon[$lat,$lon]=lon' $nf $nf
ncap2 -O -s 'flat[$lat,$lon]=lat' $nf $nf

#area=(pi/180)*R^2*((sind(latitude(i)) - sind(latitude(j)))*deltalon); % Area of each grid cell in km^2 ; R earth radius
cdo -O aexpr,'cell_area=(3.14/180)*(6371^2)*( (sin(3.14*(flat+0.02)/180) - sin(3.14*flat/180) )*0.02)' regrided.$slm regrided.gbarea.$slm

cdo infon regrided.gbarea.$slm
echo regrided.gbarea.$slm
