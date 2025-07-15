library(readxl)
library(tidyverse)
base_datos = read_xlsx("BASE.xlsx", skip = 1)
view(base_datos)
nueva_base %>% str()

#Limpiando la base de datos 

nueva_base <- base_datos %>%
              select(!c(1:2)) %>%
              rename(
              estado_marital = "ESTADO MARITAL",
              edad = EDAD,
              sexo = SEXO,
              grado_instruccion = "GRADO DE INSTRUCCIÓN",
              infeccion_covid = "¿Tuvo infección por COVID-19 en los últimos 7 meses?",
              hospitalizado_covid = "¿Se hospitalizo por COVID-19?",
              enfermedad_cronica =  "Antecedente de enfermedad crónica",
              control_enfermedad = "¿Está controlada su enfermedad?",
              clasificacion_pfeiffer = "CLASIFICACIÓN...22",
              clasificacion_mini = "CLASIFICACIÓN...44",
              clasificacion_fantastico = "CLASIFICACION"
              )

view(nueva_base)