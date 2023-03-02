library(terra)
library(sf)

list.files("./data/FLORAFAUNA1")

flora_fname <- "./data/FLORAFAUNA1/VBA_FLORA25.shp"
all_flora <-st_read(flora_fname)
#all_flora <- terra::vect(fname)
subset_flora <- all_flora[1:9]
use_data(subset_flora)

bio_fname <- "./data/FLORAFAUNA1/VBIOREG100.shp"
bioreg <- st_read(bio_fname)
terra::plot(bioreg)
use_data(bioreg)
