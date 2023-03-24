library(terra)
library(sf)
library(here)
library(devtools)
library(tidyr)

project_path = here::here()

setwd(file.path(project_path, "bioreg.app"))
list.files(file.path(project_path,"/data/FLORAFAUNA1"))

bio_fname <- file.path(project_path,"data/FLORAFAUNA1/VBIOREG100.shp")
bioreg <- st_read(bio_fname)
use_data(bioreg)
