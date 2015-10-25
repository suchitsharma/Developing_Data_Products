# Loading needed libraries
library(shiny)
library(caret)
library(lattice)
library(ggplot2)

#Loading and cleaning data
data(airquality)
airquality <- na.omit(airquality)

#Training model
Training1 <- train(Solar.R ~ ., data = airquality, method="lm");

# Shiny Details
shinyServer(
    function(input, output){
        
        InputValues <- reactive({
            data.frame(
                Ozone = c(input$ozone), 
                Wind = c(input$wind), 
                Temp = c(input$temp),
                Month = c(as.numeric(format(input$date, format="%m"))),
                Day = c(as.numeric(format(input$date, format="%d")))
            )
        });
        
        prediction <- reactive({
            predict(Training1, InputValues());
        });
        output$inputData <- renderTable({
            InputValues()
        }, include.rownames=FALSE);
        
        output$aqds <- renderTable({
            head(airquality)
        }, include.rownames=FALSE)
        
        output$SolarPrediction <- renderText({
            paste0(round(prediction(), 0), " langely")
        });
    }    
);