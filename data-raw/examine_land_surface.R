library(terra)
ddir <- "data/Land-cover-20230305"
list.files(ddir)
list.files(file.path(ddir,"SITE-SPECIES-ABUNDANCE-SHAPEFILE"))
sfile <- file.path(ddir,"SITE-SPECIES-ABUNDANCE-SHAPEFILE","shapefile_1.shp")
sv <- terra::vect(sfile)
sdf <- as.data.frame(sv,geom="XY")
