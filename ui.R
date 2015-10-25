library(shiny)
shinyUI(
    pageWithSidebar(
        headerPanel("Solar Radiation Predictor"),
        sidebarPanel(
            p("Please provide the following input:"),
            
            sliderInput('ozone', 'Ozone level (parts per billion):', 
                         min = 0.0, max = 200.00, value = 50.00, step = 1),
            
            sliderInput('wind', 'Wind velocity (miles per hour):', 
                        min = 0.0, max = 25.00, value = 5.00, step = 0.1),
            
            sliderInput('temp', 'Max Temperature (fahrenheit):', 
                        min = 50.0, max = 100.00, value = 55.00, step = 1),
            
            dateInput('date', 'Date (click to change)')
        ),
        mainPanel(
            tabsetPanel(
                tabPanel("Application",
                         p('Predicting level of Solar radiation
                           (Ly) for entered data.'),
                         h3('Input data:'), 
                         tableOutput("inputData"), 
                         h3('Prediction:'), 
                         p(
                             span('Using prediction model based on airquality data, estimated solar radiation for input values is: '),
                             h4(textOutput("SolarPrediction", inline = TRUE))
                         )
                         ),
                
                tabPanel("Server Calculations", 
                         h3('Summary'),
                         p('This Shiny application predicts the amount of Solar Radiation recieved by an area, given the values of Ozone Level, Wind Velocity, Maximum Temperature and Date.
                            '),
                         p('The prediction model is trained using airquality data set in R, sample given below'),
                         tableOutput('aqds'),
                         
                         h3('Model Build & Training'),
                         p('Model was built using caret package and trained using the following command. '),
                         pre('Training1 <- train(Solar.R ~ ., data = airquality, method="lm")')
                )
                         )            
            )
        )
    )