library(shiny)
library(googleVis)

shinyUI(pageWithSidebar(
  headerPanel("World Bank Indicators"),
  sidebarPanel(
    selectInput("year", label = p("Year"), choices = years, width="100%",
                selected = 2015 ),
    selectInput("selectY", label = p("Y Axis"), choices = indicators, width="100%",
                selected = "GDP per capita (current US$)" ),
    selectInput("selectX", label = p("X Axis"), choices = indicators, width="100%",
                selected = "PM2.5 air pollution, mean annual exposure (micrograms per cubic meter)" ),
    selectInput("selectSize", label = p("Bubble size"), choices = indicators, width="100%",
                selected = "Population, total" ),
    width = 4
  ),
  mainPanel(
    
    tabsetPanel(
      tabPanel("Plot", htmlOutput("view")),
      tabPanel("Data", dataTableOutput('table')),
      ## tabPanel("Summary", verbatimTextOutput("summary"))
      tabPanel("Source", "Data source: http://databank.worldbank.org/data/download/WDI_csv.zip" )
    )
  )
))