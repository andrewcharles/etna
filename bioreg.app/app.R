library(shiny)
library(leaflet)
library(dplyr)
library(terra)
library(sf)
library(devtools)
library(DT)

df <- load(file='./data/bioreg.rda')
#df <- load(file='./bioreg.dapp/data/bioreg.rda')
bdata <- st_as_sf(bioreg)
idcol <- "BIOREGNO"

ndata <- bdata %>% st_set_geometry(NULL)
idata <- ndata[,idcol]

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Biodiversity explorer"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
          leafletOutput("mymap")
        ),
        mainPanel(
          DTOutput('table')
        ),

    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  getLayer <- reactive({
    layer <- bdata[input$table_rows_selected ,] %>% st_transform(4326)
  })

  getxy <- function(L){
      bb <- sf::st_bbox(L)
      xi <- ((bb$xmin+bb$xmax)/2) %>% as.numeric()
      yi <- ((bb$ymin+bb$ymax)/2) %>% as.numeric()
      return(list(lat=xi,lng=yi,zoom=10))
  }

  output$table = renderDT({
    datatable(ndata,
              selection=list(mode='single',selected = 1)
    )
  })

  output$mymap <- renderLeaflet({

    layer <- bdata[input$table_rows_selected ,] %>% st_transform(4326)

    m <- leaflet(layer)  %>%
      addPolygons(color = "#444444", weight = 1, smoothFactor = 0.5,
              opacity = 1.0, fillOpacity = 0.5,
              highlightOptions = highlightOptions(color = "white", weight = 2,
                                                  bringToFront = TRUE)) %>% addProviderTiles('Esri.WorldImagery')
  })

  observe({
    #layer = getLayer()
    leafletProxy("mymap", data = getLayer()) %>%
      clearShapes() %>%
      #setView(getxy(layer)) %>%
      addPolygons(color = "#444444", weight = 1, smoothFactor = 0.5,
              opacity = 1.0, fillOpacity = 0.5,
              highlightOptions = highlightOptions(color = "white", weight = 2,
                                                  bringToFront = TRUE)
      )
  })


}

# Run the application
shinyApp(ui = ui, server = server)
