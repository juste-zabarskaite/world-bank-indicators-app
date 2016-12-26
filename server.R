library(shiny)
library(googleVis)

shinyServer( function(input, output, session) {
  
    datasetInput <- reactive({ data <- data[which(data$Year==input$year),c("Country", "Region",input$selectY,input$selectX,input$selectSize),]})
    
    ## chart
    output$view <- renderGvis({
      gvisBubbleChart(datasetInput(), 
          idvar="Country", 
          yvar=input$selectY, 
          xvar=input$selectX, 
          sizevar= input$selectSize,
          colorvar="Region",   
        options=list(
          title = paste0(input$selectY," vs. ",input$selectX,", ", input$year),
          vAxis= sprintf("{title: '%s'}",input$selectY),
          hAxis= sprintf("{title: '%s'}",input$selectX),
          bubble="{textStyle:{color: 'none'}}",
          width="100%", height=500)
        )
    })
    ## data table
    output$table <- renderDataTable(datasetInput())
    
  }
)

