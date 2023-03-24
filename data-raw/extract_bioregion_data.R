library(terra)
library(sf)

list.files("./data/FLORAFAUNA1")

bio_fname <- "./data/FLORAFAUNA1/VBIOREG100.shp"
bioreg <- st_read(bio_fname)
use_data(bioreg, overwrite=TRUE)
