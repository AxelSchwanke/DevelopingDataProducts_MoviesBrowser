library(shiny)
library(ggplot2)

shinyServer(function(input, output, session) {

  output$plot <- renderPlot({
 
    movies <- na.omit(movies)
    yMin <-min(movies$year)
    yMax <- max(movies$year)
    
    budgetMax <- max(movies$budget)


    action <- 99
    animation <- 99
    comedy <- 99
    drama <- 99
    documentary <- 99
    romance <- 99
    short <- 99
    if ( input$action) action <- 1
    if ( input$animation) animation <- 1
    if ( input$comedy) comedy <- 1
    if ( input$drama) drama <- 1
    if ( input$documentary) documentary <- 1
    if ( input$romance) romance <- 1
    if ( input$short) short <- 1
        
  dataset2 <- subset(movies, 
    movies$year >= input$years[1] & 
    movies$year <= input$years[2] &  
    movies$length >= input$lengths[1] & 
    movies$length <= input$lengths[2] &  
    movies$rating >= input$ratings[1] &  
    movies$rating <= input$ratings[2] &
    (
    movies$Action == action |
    movies$Animation == animation |
    movies$Comedy == comedy |
    movies$Drama == drama |
    movies$Documentary == documentary |
    movies$Romance == romance |
    movies$Short == short 
    )
    )
    

    xx=seq(yMin,yMax)
    xx2 <- sort(unique(dataset2$year))
    yy=rep(NA,length(xx))
    # mean movie budget per year
    for (i in 1:length(xx)) {
      ss <- subset(dataset2,dataset2$year==xx[i])
      yy[i] <- mean(ss$budget)
    }
    df <- data.frame(cbind(xx,yy))
    names(df) <- c('year','budget')
    
  p <- plot(budget ~ year, 
    data=df, 
    xlim=c(1883 ,2005),
    ylim=c(0,budgetMax),
    xlab="Year", ylab="Budget ($)", 
    main="Mean Budget of Movies")
  print(p)

  if (length(xx2)>0) {
   fit <- lm(budget~poly(year,input$poly,raw=TRUE), data=df)
    lines(xx2,fit$fitted, col='blue',lwd=1.5)
  }

  }, height=450)

})
