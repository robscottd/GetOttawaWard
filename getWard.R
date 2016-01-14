library(rgdal)
library(ggplot2)


### set working directory so shape file can be read in
#
setwd("../D4GO/BasecampDownload")
#
###

###
# Function to find whether supplied long/lat is in SpatialPolygonsDataFrame
# Will return ward name if found, empty string if not
###

getWard <- function(aLong,aLat,wp) {
    # Take supplied long/lat and create a SpatialPoint object
    pts <- SpatialPoints(cbind(aLong,aLat),
                         proj4string = CRS("+proj=longlat +datum=WGS84"))
    
    #Project long/lat to NAD83(CSRS) / MTM zone 9 format    
    MTM9 <- "+proj=tmerc +lat_0=0 +lon_0=-76.5 +k=0.9999 +x_0=304800 +y_0=0 +units=m +no_defs"
    MTM9 <- paste(MTM9, "+ellps=GRS80 +towgs84=0,0,0")
    MTM9 <-  CRS(MTM9)
    
    ## Project your points
    ptsMTM <- spTransform(pts, MTM9)
    
    x<-ptsMTM@coords[1,1]
    y<-ptsMTM@coords[1,2]
    
    theWard<-""
    for (j in 1:length(wp@polygons)) {
        fortPC<-fortify(wp@polygons[[j]])
        if (point.in.polygon(x,y,
                             fortPC$long,fortPC$lat)!=0) {
            theWard <- wp@data$DESCRIPTIO[j]
        }
    }
    return(theWard)
}



###
# Read in Ward shp file (May receive warning that z-dimension discarded - this is OK)
###

wardPoly <- readOGR(dsn='./polyWards','wards-2010-2',verbose=FALSE,stringsAsFactors=FALSE)

###
# Test with local landmarks and one outside Ottawa wards
###

TelferSchool<-getWard(-75.6869648,45.4237795,wardPoly)
ParkdaleMarket<-getWard(-75.729854,45.401473,wardPoly)
BayshoreMall<-getWard(-75.806440,45.347577,wardPoly)
EmpireStateBuilding<-getWard(-73.985621,40.748343,wardPoly)