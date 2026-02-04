#preparation of data for the intro to tmap workshop

library(terra)

#download GBR boundary 
gbr_boundary <- vect("https://services-ap1.arcgis.com/8gXWSCxaJlFIfiTr/arcgis/rest/services/Great_Barrier_Reef_Marine_Park_Boundary_20/FeatureServer/replicafilescache/Great_Barrier_Reef_Marine_Park_Boundary_20_2474222838331219096.gpkg")

gbr_boundary <- project(gbr_boundary, "EPSG:4326") #project to 4326 for the workshop

writeVector(gbr_boundary, "data/gbr_MPA_boundary.gpkg")

#Download temperature data for GBR extent from NOAA server
ext(gbr_boundary) #used to determine extent for download


## File Download - run once, then saved
tmp <- tempfile()
options(timeout = 6000)

#this is a 219 MB download
download.file("https://coastwatch.pfeg.noaa.gov/erddap/griddap/NOAA_DHW.nc?CRW_SST%5B(2022-06-01T12:00:00Z):1:(2023-05-31T12:00:00Z)%5D%5B(-10):1:(-25)%5D%5B(142):1:(155)%5D", tmp)

gbr_area_sst <- rast(tmp)

gbr_area_sst_corrected <- flip(gbr_area_sst)

plot(gbr_area_sst_corrected, fun = function()lines(gbr_boundary))

#save as cdf
writeCDF(gbr_area_sst_corrected, "data/gbr_area_sst_2022_2023.nc", overwrite = TRUE)

## END download script

#set names as date of SST measurement
names(gbr_area_sst_corrected) <- time(gbr_area_sst_corrected) |>
  format("%Y_%m_%d")

#create monthly mean temp geotiff
gbr_monthly_temp <- tapp(gbr_area_sst_corrected, index = "yearmonths", fun = mean)

time(gbr_monthly_temp) <- NULL

names(gbr_monthly_temp) <- gsub("ym_", "", names(gbr_monthly_temp)) |> 
  sub("^(.{4})", "\\1_", x = _) 

writeRaster(gbr_monthly_temp, "data/gbr_monthly_sst.tif")

#also output a single month
writeRaster(gbr_monthly_temp[[1]], "data/gbr_sst.tif")
