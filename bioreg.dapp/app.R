library(shiny)
library(leaflet)
library(dplyr)
library(terra)
library(sf)
library(devtools)

data <- st_as_sf(bioreg)
idcol <- "BIOREGNO"
idata <- data[,idcol] %>% st_set_geometry(NULL)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Biodiversity explorer"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
          selectInput(
            inputId = "selection",
            label = "Layer",
            choices = idata[,idcol]
          )
        ),

        mainPanel(
          leafletOutput("mymap")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  index <- reactive({input$selection})


  getLayer <- reactive({
    idx <- which(idata[,idcol] == input$selection)
    layer <- data[idx,] %>% st_transform(4326)
  })

  output$mymap <- renderLeaflet({

    # make this dynamically zoom to the region
    layer <- getLayer()
    # alternatively start the map using static data and use the observer below to update
    #layer <- data[1,] %>% st_transform(4326)

    m <- leaflet(layer)  %>% addPolygons(color = "#444444", weight = 1, smoothFactor = 0.5,
              opacity = 1.0, fillOpacity = 0.5,
              highlightOptions = highlightOptions(color = "white", weight = 2,
                                                  bringToFront = TRUE)) %>% addTiles()
  })

  observe({
    leafletProxy("mymap", data = getLayer()) %>%
      clearShapes() %>%
      addPolygons(color = "#444444", weight = 1, smoothFactor = 0.5,
              opacity = 1.0, fillOpacity = 0.5,
              highlightOptions = highlightOptions(color = "white", weight = 2,
                                                  bringToFront = TRUE)
      )
  })


}

# Run the application
shinyApp(ui = ui, server = server)
