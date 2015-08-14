library(shiny)
library(ggplot2)

dataset <- na.omit(movies)
yearMin <- min(movies$year)
yearMax <- max(movies$year)

rMin <- min(movies$rating)
rMax <- max(movies$rating)

lMin <- min(movies$length)
lMax <- max(movies$length)
lMax <- 500


shinyUI(pageWithSidebar(

  headerPanel("Movies Browser"),

  sidebarPanel(
    
    sliderInput("years", "Release Date [Year]:",
                  min = yearMin, max = yearMax, 
                  value = c(yearMin,yearMax), 
                  step=1, format="####"),

    sliderInput("lengths", "Movies Length [min]:",
                  min = lMin, max = lMax, 
                  value = c(lMin,lMax), step=1, format="####"),
                  
    sliderInput("ratings", "Rating [1=Low  10=High]:",
                  min = rMin, max = rMax, value = c(rMin,rMax) ),


    helpText("Genre:"),
    checkboxInput('action', 'Action', value=TRUE),
    checkboxInput('animation', 'Animation'),
    checkboxInput('comedy', 'Comedy'),
    checkboxInput('drama', 'Drama'),
    checkboxInput('documentary', 'Documentary'),
    checkboxInput('romance', 'Romance'),
    checkboxInput('short', 'Short'),
              
    sliderInput("poly", "Degree of polynomial regression:",
                  min = 1, max = 10, 
                  value = 1,
                  step=1)

  ),

  mainPanel(
    plotOutput('plot')
  )
))
