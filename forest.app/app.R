#
library(shiny)
library(leaflet)
library(dplyr)

library(sf)
# From https://www.census.gov/geo/maps-data/data/cbf/cbf_state.html
forests <- sf::read_sf("data/FORESTS/OGMAP100.shp")


# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Biodiversity explorer"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
          selectInput(
            inputId = "selection",
            label = "Forest",
            choices = 1:10
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
  idx <- input$selection
  print(idx)
  layer <- forests[idx,] %>% st_transform(4326)
   m <- leaflet(layer)  %>% addPolygons(color = "#444444", weight = 1, smoothFactor = 0.5,
              opacity = 1.0, fillOpacity = 0.5,
              highlightOptions = highlightOptions(color = "white", weight = 2,
                                                  bringToFront = TRUE)) %>% addTiles()
  })
}

# Run the application
shinyApp(ui = ui, server = server)
