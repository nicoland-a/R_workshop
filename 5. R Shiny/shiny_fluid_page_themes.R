if (!require(pacman)) {
  install.packages("pacman")
  require(pacman)
}
pacman::p_load(shiny, shinyjs, shinycssloaders, shinythemes, DT, plotly, lubridate,
               glue, tidyr, tidyverse, data.table, magrittr, dplyr, purrr, openxlsx, readxl, 
               zoo, aweek, stringr, shinydashboard, ggplot2, shinyWidgets)

#Data to be used in example:
Dashboard_data <- iris  


#User interface. FluidPage example
ui <- {fluidPage(
  shinythemes::themeSelector(),
  shinyjs::useShinyjs(),
  #Browser tab title:
  list(tags$head(HTML('<link rel="icon", href="nicola_logo1.png",
                      type="image/png" />'))),
  div(style="padding: 1px 0px; width: '100%'",
      titlePanel(
        title="", windowTitle="My app title"
      )
  ),
  
  navbarPage(
    title=div(img(src = "nicola_logo1.png", style = "margin-top: -15px;", height = 51),
              "My app title"),
    #shinytheme. Currently using "united"
    #theme = shinytheme("united"),
    
    # Tab Panel
    {
      
      tabPanel("Tab Panel 1",
               
               fluidRow(
                 h1("FluidRow contents here...", align="center" )
               ),
               fluidRow(
                 column(6,
                        h2("FluidRow-column 1 width=6")),
                 column(4,
                        h2("FluidRow-column 2 width=4")),
                 column(2,
                        h2("FluidRow-column 3 width=2"))
               ),
               
               fluidRow(
                 p("Yet another fluidrow...", align="center") 
               )
      )}
    , tabPanel("Tab Panel 2",
               tabsetPanel(
                 tabPanel("Tab 1",
                          plotlyOutput("Plot_1")),
                 tabPanel("Tab 2",
                          plotlyOutput("Plot_2")),
                 tabPanel("Tab 3")
               )
               
    )
    
    
    
  ) 
)}

server <- function(input, output, session) {
  
  output$Plot_1 <- renderPlotly({
    
    a <- plot_ly(data = Dashboard_data, x = ~Sepal.Length, y = ~Petal.Length, color = ~Species)
    
  })
  output$Plot_2 <- renderPlotly({
    
    a <- ggplot(data=Dashboard_data, aes(x=Sepal.Width)) +
      geom_histogram(binwidth=0.2, aes(fill=Species)) + 
      xlab("Sepal Width") +  ylab("Freq") + ggtitle("Histogram Example")
    
    a <- ggplotly(a, tooltip=NULL) %>% layout(plot_bgcolor='rgb(255, 255, 255)') %>%
      layout(paper_bgcolor='rgb(255, 255, 255)')
  })
  
  
}

# Run the application
app <- shinyApp(ui = ui, server = server)
#runApp(app, launch.browser = T)