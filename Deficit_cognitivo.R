library(readxl)
library(rmarkdown)
library(tidyverse)
library(gtsummary)
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

#Cambiar variables 

nueva_base <- nueva_base %>% 
              mutate(
              sexo = as.factor(sexo),
              estado_marital = as.factor(estado_marital),
              grado_instruccion = as.factor(grado_instruccion),
              infeccion_covid = as.factor(infeccion_covid),
              hospitalizado_covid = as.factor(hospitalizado_covid),
              enfermedad_cronica = as.factor(enfermedad_cronica),
              control_enfermedad = as.factor(control_enfermedad)
              )

## Nombrando variables

nueva_base <- nueva_base %>%
              mutate(
              sexo = factor(sexo, levels = c(0,1), labels = c("Masculino", "Femenino")),
              estado_marital = factor(estado_marital, levels = c(0,1), labels = c("Sin pareja","Con pareja")),
              grado_instruccion = factor(grado_instruccion, levels = c(0,1,2,3,4,5,6,7),labels = c("Primaria completa","Primaria incompleta","Secundaria completa","Secundaria incompleta","universidad completa","Universidad incompleta","Tecnica completa","Tecnica incompleta")),
              infeccion_covid = factor(infeccion_covid, levels = c(0,1), labels = c('No','Si')),
              hospitalizado_covid = factor(hospitalizado_covid, levels = c(0,1,2), labels = c("No", 'Si,en hospitalizacion general','Si, en cuidados intensivos')),
              enfermedad_cronica = factor(enfermedad_cronica, levels = c(0,1,2,3,4,5,6,7), labels = c("Diabetes mellitus","Hipertension","Asma","Cardiopatia","Hipotiroidismo","Enfermedad renal cronica","EPOC","Otros")),
              control_enfermedad = factor(control_enfermedad, levels = c(0,1,2), labels = c("Bien controlada","Moderadamente controlada","Mal controlada"))
              )
              
## Tabla 1
tabla1_datos <- nueva_base %>% 
                select(
                edad,
                sexo,
                estado_marital,
                grado_instruccion,
                infeccion_covid,
                hospitalizado_covid,
                enfermedad_cronica,
                control_enfermedad
                )

tabla1 <- tabla1_datos %>% 
          tbl_summary(
          statistic = list(
          all_continuous() ~ "{mean} ({sd})",
          all_categorical() ~ "{n} ({p}%)"
          ),
          digits = list(
          all_continuous() ~ c(1, 1),
          all_categorical() ~ c(0, 1),
          label= list(
          edad ~ "Edad",
          sexo ~ "Sexo",
          estado_marital ~ "Estado Marital",
          grado_instruccion ~ "Grado de instruccion",
          infeccion_covid ~ "¿Tuvo infección por COVID 19 en los últimos 7 meses?",
          hospitalizado_covid ~ "Hospitalizado por COVID-19?",
          enfermedad_cronica ~ "Antecendentes enfermedad cronica",
          control_enfermedad ~ "¿Está controlada su enfermedad?"
          ),missing = "no"
          ) %>% 
          modify_header(label ~ "**Caracteristicas**") %>% 
          modify_spanning_header(all_stat_cols() ~ "***N = 126*")

view(nueva_base)