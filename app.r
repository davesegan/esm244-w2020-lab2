# Attach packages
library(tidyverse)
library(shiny)
library(shinythemes)
library(here)

# Read in spooky_data.csv

spooky <- read_csv(here("data", "spooky_data.csv"))

# Create my user interface
ui <- fluidPage(
  theme = shinytheme("spacelab"),
  titlePanel("First app, awesome title"),
  sidebarLayout(
    sidebarPanel("My widgest are here",
                 selectInput(inputId = "state_select",
                             label = "Choose a state:",
                             choice = unique(spooky$state)
                             )
                 ),
    mainPanel("My outputs are here!",
              tableOutput(outputId = "candy_table") # step 4 to show output in UI. if it were a graph, plotOutput
              )
    )
)

server <- function(input, output) {

  state_candy <- reactive({
    spooky %>%
      filter(state == input$state_select) %>%
      select(candy, pounds_candy_sold)
  })

  output$candy_table <- renderTable({
    state_candy()
  })

}

shinyApp(ui = ui, server = server)
