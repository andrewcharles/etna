library(terra)
library(sf)
library(here)

flora_fname <- file.path(here::here('data'),"FLORAFAUNA1/VBA_FLORA25.shp")

st_layers(flora_fname)
fields <- st_read(flora_fname, query='select * from "VBA_FLORA25" limit 0')
fnames <- fields %>% names()
#ftypes <- fields %>% class()
class(fields$SITE_ID)

all_flora <-st_read(flora_fname)

sbox = st_bbox(c(xmin=144.4, xmax=144.75, ymin=-38.31, ymax=-38.11), crs= st_crs(4326))

#all_flora <- terra::vect(fname)
subset_flora <- all_flora[1:9]
wkt <- st_as_text(st_as_sfc(sbox))
subset_flora <- st_read(flora_fname, wkt_filter = wkt)

use_data(subset_flora,overwrite=TRUE)
