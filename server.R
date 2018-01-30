
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    data(iris)
    library(ggplot2)
    library(caret)
    library(randomForest)
    
    inTrain <- createDataPartition(y=iris$Species,
                                   p=0.7, list=FALSE)
    training <- iris[inTrain,]
    testing <- iris[-inTrain,]
    
    model1 <- train(Species~ Petal.Length + Petal.Width,data=training,method="rf",prox=TRUE)
    
    p <- ggplot(data = iris,aes(x = Petal.Width,y = Petal.Length,col = Species)) +
        stat_ellipse(type = "t",level = 0.9,size = 1.,linetype =2) +
        geom_point(aes(x = Petal.Width,y = Petal.Length,col = Species),size = 3,alpha = 0.5) +
        scale_color_manual(name = "Species",values = c('#377eb8','#e41a1c','#4daf4a')) +
        scale_x_continuous(name = "Petal width",breaks = seq(0,3,by = 0.4))+
        scale_y_continuous(name = "Petal length",breaks = seq(1,7,by = 1)) +
        theme(panel.background = element_blank(),
              panel.border = element_rect(size=0.5,colour = "black",fill = NA),
              panel.grid.major.x = element_line(colour = "grey90",size = 0.5),
              panel.grid.major.y = element_line(colour = "grey90",size = 0.5),
              axis.text = element_text(size=12,colour="black"),
              axis.title = element_text(size=12,colour = "black"),
              axis.ticks = element_line(size=0.5),
              axis.ticks.length = unit(.15, "cm"),
              plot.title = element_text(face="bold",size = 15, colour = "grey20",hjust = 0.5),
              legend.title = element_text(size = 14,colour = "black"),
              legend.text = element_text(size = 12,colour = "black"),
              legend.key = element_blank())
    
    
    model1pred <- reactive({
        p.len <- input$p.len
        p.wid <- input$p.wid
        newdat <- data.frame(Petal.Length=p.len,Petal.Width = p.wid)
        predict(model1,newdata = newdat)
    })
    
    irisP <- reactive({
        p.len <- input$p.len
        p.wid <- input$p.wid
        data.frame(Petal.Length=p.len,Petal.Width = p.wid,
                   Species = predict(model1,newdata = newdat))
     })
    

    output$plot1 <- renderPlot({
        
        if(input$showModel1) {
            colors <- c('#377eb8','#e41a1c','#4daf4a')
            p + geom_point(aes(x=Petal.Width,y=Petal.Length,col=Species),col = colors[model1pred()],
                           size=6,shape = 18,data=irisP()) 
        } else {
            p
        }
        
    })
    output$pred1 <- renderText({
        levels(iris$Species)[model1pred()]
    })
    
})