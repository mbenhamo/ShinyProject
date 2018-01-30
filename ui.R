
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Predict Iris species"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
      sidebarPanel(
          sliderInput("p.len","What is the length of the petal?",1,7,value = 4),
          sliderInput("p.wid","What is the width of the petal?",0.1,2.5,value = 1),
          checkboxInput("showModel1","Show/Hide Random Forest Prediction",value = FALSE),
          submitButton("Submit")
      ),

    # Show a plot of the generated distribution
    mainPanel(
        plotOutput("plot1"),
        h3("Predicted Iris species"),
        h3("using a random forest model:"),
        textOutput("pred1")
    )
  )
))