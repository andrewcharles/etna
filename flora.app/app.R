library(shiny)
library(leaflet)
library(dplyr)
library(terra)
library(sf)
library(devtools)
# From https://www.census.gov/geo/maps-data/data/cbf/cbf_state.html
data <- st_as_sf(subset_flora)

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
            choices = data$RECORD_ID
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

  output$mymap <- renderLeaflet({

    idx <- data$RECORD_ID == input$selection
    #idx <- data$RECORD_ID == data$RECORD_ID[1]
    #print(idx)
    layer <- data[,] %>% st_transform(4326)

    m <- leaflet(layer)  %>% addCircleMarkers(color = "#444444", radius = 0.1, stroke = 0.1,
              opacity = 1.0, fillOpacity = 0.5) %>% addTiles()
  })
}

# Run the application
shinyApp(ui = ui, server = server)
