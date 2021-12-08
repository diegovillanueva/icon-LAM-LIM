
# 1 deg aprox 100km -> 0.01 aprox 1 km -> 0.02 aprox 2km

#init
ilon=-62
ilat=8
#range
rlon=12
rlat=10
#step
s=0.02

print "step aprox " + str(100*s) + " km (should be 2km)"
print "lon between " + str(ilon) + " and " + str( ilon + rlon ) + " should be -62 to -50"
print "lat between " + str(ilat) + " and " + str( ilat + rlat ) + " should be 8 to 18 "


print
print "xsize    = " + str(int(rlon/s))
print "ysize    = " + str(int(rlat/s))
print "xfirst   = " + str(ilon)
print "xinc     = " + str(s)
print "yfirst   = " + str(ilat)
print "yinc     = " + str(s)


