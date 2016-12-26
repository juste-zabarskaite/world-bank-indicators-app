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
      ## tabPanel("Source", "Data source: http://databank.worldbank.org/data/download/WDI_csv.zip. Code: https://github.com/juste-zabarskaite/world-bank-indicators-app" )
      tabPanel("Documentation", withTags({
        div(class="header", checked=NA,
            p(""),
            p("The purpose of this app is to visualise dependencies between World Bank indicators (GDP, population, etc.) for exploratory analysis."),
            p(""),
            p("Data source (accessed 24/12/2016):"),
            a(href="http://databank.worldbank.org/data/download/WDI_csv.zip", "http://databank.worldbank.org/data/download/WDI_csv.zip"),
            p(""),
            p("Code:"),
            a(href="https://github.com/juste-zabarskaite/world-bank-indicators-app", "https://github.com/juste-zabarskaite/world-bank-indicators-app")
        )
      }) )
    )
  )
))