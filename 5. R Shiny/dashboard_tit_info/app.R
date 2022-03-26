if (!require(pacman)) {
  install.packages("pacman")
  require(pacman)
}
pacman::p_load(shiny, shinyjs, shinycssloaders, shinythemes, 
               shinydashboard)


#Título de header con imagen:
header <- list(tags$head(tags$style()),
     HTML('<img src = "nicola_logo1.png", height = "51",
          style = "float:left"/>' , '<p style = "color:black"></p>'),
     title = "Título de la App")
header <- dashboardHeader(title = header,
                         tags$li(actionLink("openModal", label = "",
                                            icon = icon("info")),
                                 class = "dropdown"))
sidebar <- dashboardSidebar()

body <- dashboardBody()
ui <- dashboardPage(list(tags$head(HTML(
  '<link rel="icon", href="nicola_logo1.png", type="image/png" />')),
  title="Titulo para Browser"),
  header = header,
  sidebar = sidebar,
  body = body)

server <- function(input, output, session){
  observeEvent(input$openModal, {
    showModal(
      modalDialog(title = "Dashboard Author/Maintainer: Juanito",
                  p("Contacto:"),
                  p("correo_de_juanito@maildir.com"),
                  p("agregar más líneas con más info..."))
    )
  })
}



app <- shinyApp(ui, server)

