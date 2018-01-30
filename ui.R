
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ggplot2)
library(caret)
library(randomForest)
library(e1071)

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
        tabsetPanel(type = "tabs",
                    tabPanel("Plot",plotOutput("plot1"),
                             h3("Predicted Iris species"),
                             h3("using a random forest model:"),
                             textOutput("pred1")),
                    tabPanel("Help",h5("This is a shiny application generated as part of the requirements
                                       for the 'Data Products' course in Coursera. In this application,
                                       the user can insert (using the slidebar) the length and the width
                                       of a hypothetical iris flower, and then a random forest model
                                       will use these values to predict the specific iris species of the
                                       flower."),
                             h5("The source server.R and ui.R files can be found in github:"),
                             h5(a("ShinyProject Repository",href = "https://github.com/mbenhamo/ShinyProject"))))
        
    )
  )
))