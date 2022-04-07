#CARGAR LIBRERIAS
##if (!require(pacman)) {
  #install.packages("pacman")
  #require(pacman)
#}
#pacman::p_load(shinydashboard, shiny, shinyjs, shinycssloaders, shinythemes, shinyWidgets,
 #              gapminder, plotly, leaflet)
library(shinydashboard)
library(shiny)
library(shinyjs)
library(shinycssloaders)
library(shinythemes)
library(shinyWidgets)
library(gapminder)
library(plotly)
library(leaflet)


### Datos ####
#datos_input <- write_csv("url____")
datos_input <- gapminder::gapminder

### ui ####
#Crear un dashboard
titulo <- list(tags$head(tags$style()),
               HTML('<img src = "nicola_logo1.png", height = "51",
          style = "float:left"/>' , '<p style = "color:black"></p>'),
               title = "Ejemplo_25_3_22")
header <- dashboardHeader(
  title = titulo,
  tags$li(actionLink("openModal", label = "",
                     icon = icon("info")),
          class = "dropdown")#,
  #dropdownMenu(
   # type = "notifications",
    #notificationItem("Notificacion_1")
  #)
)

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Item 1", tabName = "Item_1", icon = icon("book")),
    menuItem("Item 2", tabName = "Item_2", icon = icon("table")),
    menuItem("La yapa", tabName = "La_Yapa"),
    sliderInput(
      inputId = "Slider_1",
      label = "Numero",
      min = 0,
      max = 100,
      value = 50
    ),
    textInput("text_1",
              label = "Skin:")
  )
)

body <- dashboardBody(
  #Si tienes un archivo css para estilo de la app
  #includeCSS("path_al_archivo.css")
  tabItems(
    tabItem(tabName = "Item_1",
            fluidRow(
              box(title = "Caja 1", width = 12,
                  collapsible = TRUE, collapsed = TRUE)
            ),
            fluidRow(
              column(6,
                     valueBox(15, icon = icon("star"),
                              subtitle = "Número de asistentes de hoy (estático)",
                              width = 6)),
              column(6,
                     valueBoxOutput("caja_server"))
            )),
    tabItem(tabName = "Item_2",
            fluidRow(
              column(4, 
                     selectInput("Input_1", label = "Continente(s)",
                                 choices = levels(as.factor(datos_input$continent)),
                                 multiple =  TRUE,
                                 selected = "Africa")),
              column(4,
                     selectInput("Year_1", label = "Desde",
                                 choices = levels(as.factor(datos_input$year)))),
              column(4,
                     selectInput("Year_2", label = "Hasta",
                                 choices = levels(as.factor(datos_input$year))),
                     selected = max(datos_input$year))
            )
            ,
            plotlyOutput("Plot_Gap")),
    tabItem(tabName = "La_Yapa",
            numericInput("long", 
                         label = "Longitud",
                         value = -78.4887,),
            numericInput("lat",
                         label = "Latitud",
                         value = -0.2102),
            leafletOutput("Map_1"))
  )
)

ui <- dashboardPage(
  skin = "blue",
  header = header,
  sidebar = sidebar,
  body = body
)


### server ####

server <- function(input, output, session) {
  observeEvent(input$openModal, {
    showModal(
      modalDialog(title = "Dashboard Author/Maintainer: Juanito",
                  p("Contacto:"),
                  p("correo_de_juanito@maildir.com"),
                  p("agregar más líneas con más info..."))
    )
  })
  output$caja_server <- renderValueBox({
    valueBox(
      value = input$Slider_1,
      subtitle = "Valor del slider"
    )
  })
  
  output$Plot_Gap <- renderPlotly({
    plot_gapminder <- datos_input %>%
      filter(continent== input$Input_1,
             year>=input$Year_1,
             year<=input$Year_2) %>%
      ggplot(aes(year, lifeExp, color = country, size = gdpPercap)) +
      geom_point() + 
      labs(title = paste0("Grafico de ", input$Input_1)) +
      xlab("Año") +
      ylab("Esperanza de Vida") 
    a <- ggplotly(plot_gapminder)
    
  })
  
  output$Map_1 <- renderLeaflet({
    map <- leaflet() %>% 
      addTiles() %>%
      leaflet::addCircleMarkers(lng = input$long, lat = input$lat)
  })
  
  output$TEXT_1 <- renderText({
    
    input$text_1
  })
  
} 

app <- shinyApp(ui, server)
#runApp(app)



