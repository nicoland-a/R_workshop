source("Ejemplo de Scripts/Funciones.R")
source("Ejemplo de Scripts/Valores.R")

lista_de_archivos <- list.files("Data")

#leer como ejemplo archivos de datos en formato .csv
list_csv <- lapply(lista_de_archivos, read.csv)

func_1()

res <- func_2(2, 3)


#source("app.R")