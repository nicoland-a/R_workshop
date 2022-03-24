source("Ejemplo de Scripts/Funciones.R")
source("Ejemplo de Scripts/Valores.R")

lista_de_archivos <- list.files("Ejemplo de Scripts/Data")
lista_2 <- list.files("Ejemplo de Scripts", pattern = "*.R")
#leer como ejemplo archivos de datos en formato .csv
list_csv <- lapply(lista_de_archivos, function(x) read.csv(paste0("Ejemplo de Scripts/Data/", x)))
list_R_Files <- sapply(lista_2, function(x) source(paste0("Ejemplo de Scripts/", x)))

func_1()

res <- func_2(2, 3)


#source("app.R")