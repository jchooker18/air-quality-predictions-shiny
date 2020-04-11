library(shiny)

shinyUI(fluidPage(

    titlePanel("Predicting Air Quality in New York"),

    sidebarLayout(
        sidebarPanel(
            sliderInput("sliderSolar", "What is the level of solar radiation in Langleys?", 
                        10, 330, 150),
            sliderInput("sliderWind", "What is the average wind speed in mph?", 
                        1, 20, 10),
            sliderInput("sliderTemp", "What is the max daily temperature in degrees Fahrenheit?", 
                        56, 95, 75),
            selectInput("selectVar", "Select a variable to compare to Ozone:", 
                        c("Solar Radiation","Wind Speed","Temperature")),
            submitButton("Submit")
        ),
    
        mainPanel(
            tabsetPanel(type = "tabs",
                tabPanel("Documentation", br(),
                         h5("Overview"),
                         p("Welcome to the Prediciting Air Quality in New York shiny application. 
                            The app will allow you to predict ozone levels (the measure used to 
                           determine air quality) based on solar radiation levels, wind speed, 
                           and temperature values of your choice. The purpose of this application is
                           to allow you to see the difference in predicted air quality when 
                           modeling on only one of these variables versus accounting for all three. 
                           The data used in this application come from the ", 
                           a(href = "https://www.rdocumentation.org/packages/datasets/versions/3.6.2/topics/airquality", 
                             em("airquality")), 
                           "dataset that comes preloaded in R."),
                         br(),
                         h5("Instructions"),
                         p("In the sidebar at left, choose a value for solar radiation in Langleys,
                            average wind speed in mph, and max daily temperature in degrees 
                            Fahrenheit. Then, select one of the three variables to plug into a 
                            linear model to predict the value of ozone. Finally, click the Submit
                            button when you are ready to see the results."),
                         br(),
                         h5("Results"),
                         p("In the Prediction tab, you will see a plot showing the effect of the
                           variable you chose on air quality. The plot will display the variable on
                           the x-axis, ozone on the y-axis, a line for the linear model fitting the
                           variable and ozone, and a point with the predicted ozone level at the
                           value of the variable you specified."),
                         p("Below the plot, you will first see the same value of ozone specified in
                           the plot above, as calculated by the single-variable linear model. Below
                           that, you will see a different value of ozone, this time as calculated by
                           a linear model accounting for all three variables. Notice how this changes
                           when you alter the values for any of the three variables, while the first
                           predicted ozone value only relies on your selected variable. This shows
                           the effect of excluding relevant variables from a predictive model.")),
                tabPanel("Prediction", br(),
                         plotOutput("solarPlot"),
                         h5("Predicted value of Ozone accounting for only the selected variable:"),
                         textOutput("pred1"),
                         h5("Predicted value of Ozone accounting for all three variables:"),
                         textOutput("pred2")
                )
            )
        )
    )
))
