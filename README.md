# Get Ottawa Ward Name

R function to get Ottawa ward name for a ward containing a provided long/lat point. If long/lat is not within Ottawa ward boundaries, an empty string is returned.  

## Required R Libraries

1. rgdal   - Need readOGR to load Spatial objects.  Also for Spatial object manipulation  
2. ggplot2 - Need fortify to convert Spatial object to dataframe

## Required Shape File

1. wards-2010-2: http://data.ottawa.ca/dataset/13deeed4-1cd5-4a68-a10d-9839d3677446/resource/6abe3aa1-4ad8-4061-bb18-dad5054b85fb/download/wards-2010-2.shp.zip

## Usage

getWard(long,lat,wp)

## Arguments

long - Longitude of point

lat  - Latitude of point

wp   - SpatialPolygonsDataframe containing Ottawa ward polygons

## Value

Returns a string containing the name of the provided point's Ward if the point is within the boundaries of the Ottawa wards.  Returns an empty string if the provided point is not with the Ottawa ward boundary.

## Note

Function converts the provided long/lat point to a Modified Tranverse Mercator, Zone 9 point.  This is the format for the shape file provided by the Ottawa Open Data website.  You need to have basic understanding of working with GIS shape files in R to use this function.

## Example Function Calls

At the bottom of file getWard.R, there are 4 function calls to show you who the function works.  The first 3 calls are for points within the Ottawa ward boundaries.  the 4th call is for the Empire State Building and should return an empty string.
