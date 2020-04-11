library(shiny)

shinyServer(function(input, output) {
    solarModel <- lm(Ozone ~ Solar.R, data = airquality)
    windModel <- lm(Ozone ~ Wind, data = airquality)
    tempModel <- lm(Ozone ~ Temp, data = airquality)
    totalModel <- lm(Ozone ~ Solar.R + Wind + Temp, data = airquality)
    
    solarPred <- reactive({
        solarInput <- input$sliderSolar
        predict(solarModel, newdata = data.frame(Solar.R = solarInput))
    })
    
    windPred <- reactive({
        windInput <- input$sliderWind
        predict(windModel, newdata = data.frame(Wind = windInput))
    })
    
    tempPred <- reactive({
        tempInput <- input$sliderTemp
        predict(tempModel, newdata = data.frame(Temp = tempInput))
    })
    
    totalPred <- reactive({
        solarInput <- input$sliderSolar
        windInput <- input$sliderWind
        tempInput <- input$sliderTemp
        predict(totalModel, newdata =
                    data.frame(Solar.R = solarInput,
                               Wind = windInput,
                               Temp = tempInput))
    })
    

    output$solarPlot <- renderPlot({
        solarInput <- input$sliderSolar
        windInput <- input$sliderWind
        tempInput <- input$sliderTemp

        if(input$selectVar == "Solar Radiation"){
            plot(airquality$Solar.R, airquality$Ozone, 
                 main = "Effect of Solar Radiation on Air Quality", 
                 xlab = "Solar Radiation", 
                 ylab = "Ozone", bty = "n", pch = 16,
                 xlim = c(0, 340), ylim = c(0, 170))
            abline(solarModel, col = "red", lwd = 2)
            points(solarInput, solarPred(), col = "red", pch = 16, cex = 2)
        }
        
        else if(input$selectVar == "Wind Speed"){
            plot(airquality$Wind, airquality$Ozone, 
                 main = "Effect of Wind Speed on Air Quality",
                 xlab = "Avg. Wind Speed", 
                 ylab = "Ozone", bty = "n", pch = 16,
                 xlim = c(0, 22), ylim = c(0, 170))
            abline(windModel, col = "red", lwd = 2)
            points(windInput, windPred(), col = "red", pch = 16, cex = 2)
        }
        
        else if(input$selectVar == "Temperature"){
            plot(airquality$Temp, airquality$Ozone, 
                 main = "Effect of Solar Radiation on Air Quality",
                 xlab = "Max Daily Temperature", 
                 ylab = "Ozone", bty = "n", pch = 16,
                 xlim = c(55, 100), ylim = c(0, 170))
            abline(tempModel, col = "red", lwd = 2)
            points(tempInput, tempPred(), col = "red", pch = 16, cex = 2)
        }
    })
    
    output$pred1 <- renderText({
        if(input$selectVar == "Solar Radiation"){solarPred()}
        else if(input$selectVar == "Wind Speed"){windPred()}
        else if(input$selectVar == "Temperature"){tempPred()}
    })
    
    output$pred2 <- renderText({
        totalPred()
    })
})