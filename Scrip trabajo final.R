
_______________________________________________________________________________________

# ------ DESCARGAR LAS 19 VARIABLES DE WORLDCLIM DE 1970 AL 2000 ----------

# Instalar paquete si no está instalado
install.packages("geodata")
install.packages("terra")

# configurar directorio de trabajo
setwd("D:/TRABAJOFINAL/CapasBioclimáticas/PRESENTE")

# Cargar el paquete
library(geodata)
library(terra)

# Descargar las 19 variables bioclimáticas (resolución de 2.5 minutos)
bioclim <- worldclim_global(var = "bio", res = 2.5, path = "worldclim_data")

# Mostrar información del raster
print(bioclim)

# -------------   RECORTAR LAS 19 CAPAS DE WORLDCLIM USANDO UN SHAPEFILE ---------------
#Instalar paquetes
library(terra)
library(dismo)

# Definir rutas de entrada y salida
raster_dir <- "D:/TRABAJOFINAL/CapasBioclimáticas/PRESENTE/worldclim_data/climate/wc2.1_2.5m/"  # Carpeta donde están las capas .tif
output_dir <- "D:/TRABAJOFINAL/CapasBioclimáticas/PRESENTE/Recortadas"  # Carpeta donde se guardarán los archivos recortados
shapefile_path <- "D:/TRABAJOFINAL/CapasBioclimáticas/MEX shapefile/mex_adm0.shp"  # Ruta del shapefile
 
# Cargar el shapefile
vector <- vect(shapefile_path)

# Obtener la lista de archivos raster en la carpeta
raster_files <- list.files(raster_dir, pattern = "\\.tif$", full.names = TRUE)

# Iterar sobre cada capa raster y recortarla con el shapefile
for (raster_path in raster_files) {
  
  # Cargar la capa raster
  raster_layer <- rast(raster_path)
  
  # Asegurar que el shapefile tenga el mismo CRS que el raster
  vector <- project(vector, crs(raster_layer))
  
  # Recortar el raster con el shapefile
  raster_recortado <- crop(raster_layer, vector)  # Recorta la extensión  
  raster_recortado <- mask(raster_recortado, vector)  # Aplica la máscara
  
  # Definir el nombre del archivo de salida
  raster_name <- gsub("\\.tif$", "", basename(raster_path))  # Obtener el nombre sin extensión
  output_path <- file.path(output_dir, paste0(raster_name, ".asc"))
  
  # Guardar el raster recortado en formato ASCII (.asc)
  writeRaster(raster_recortado, output_path, filetype = "AAIGrid", overwrite = TRUE)
  
  # Mensaje de confirmación
  cat("Guardado:", output_path, "\n")
}

# Nota: como todas las capas recortadas presentaban NA, estas se recortaron directamente en QGIS para evitar este problema con todos los recortes.

raster_dir2 <- "D:/TRABAJOFINAL/CapasBioclimáticas/PRESENTE/Recortadas QGIS/"   # ruta  ala carpeta donde están las capas recortadas .asc



_____________________________________________________________________________________________________

# ----------- Descargar variables bioclimáticas de Worldclim para el Holoceno medio a 2.5 minutos -------------------

install.packages(c("geodata", "archive"))
library(geodata)
library(archive)

#Configurar el directorio de trabajo
setwd("D:/TRABAJOFINAL/CapasBioclimáticas/HOLOCENOMED")

# Definir directorio de descarga
dir.create("D:/TRABAJOFINAL/CapasBioclimáticas/HOLOCENOMED", showWarnings = FALSE)

# Descargar datos del Holoceno de WorldClim v1.4 con resolución de 2.5 minutos
download.file("https://geodata.ucdavis.edu/climate/cmip5/mid/memidbi_2-5m.zip",
              destfile = "bio_Holoceno.zip", mode = "wb")

# Extraer archivos
archive::archive_extract("bio_Holoceno.zip", dir = "Holoceno-medio")

# Listar archivos extraídos
list.files("Holoceno-medio")

# Cargar raster de una variable bioclimática
library(raster)
bio1 <- raster("Holoceno-medio/memidbi1.tif")
plot(bio1, main="BIO1 - Temperatura media anual (Holoceno Medio)")




# ------------ RECORTAR LAS 19 CAPAS DE WORLDCLIM DEL HOLOCENO USANDO UN SHAPEFILE ---------------

install.packages("terra")
library(terra)

# configurar directorio de trabajo
setwd("D:/TRABAJOFINAL/CapasBioclimáticas/HOLOCENOMED/Recortadas")

# Definir rutas de entrada y salida
raster_dir <- "D:/TRABAJOFINAL/CapasBioclimáticas/HOLOCENOMED/Holoceno-medio"  # Carpeta donde están las capas .tif
output_dir <- "D:/TRABAJOFINAL/CapasBioclimáticas/HOLOCENOMED/Recortadas"  # Carpeta donde se guardarán los archivos recortados
shapefile_path <- "D:/TRABAJOFINAL/CapasBioclimáticas/MEX shapefile/mex_adm0.shp"  # Ruta del shapefile

# Cargar el shapefile
vector <- vect(shapefile_path)

# Obtener la lista de archivos raster en la carpeta
raster_files <- list.files(raster_dir, pattern = "\\.tif$", full.names = TRUE)

# Iterar sobre cada capa raster y recortarla con el shapefile
for (raster_path in raster_files) {
  
  # Cargar la capa raster
  raster_layer <- rast(raster_path)
  
  # Asegurar que el shapefile tenga el mismo CRS que el raster
  vector <- project(vector, crs(raster_layer))
  
  # Recortar el raster con el shapefile
  raster_recortado <- crop(raster_layer, vector)  # Recorta la extensión  
  raster_recortado <- mask(raster_recortado, vector)  # Aplica la máscara
  
  # Definir el nombre del archivo de salida
  raster_name <- gsub("\\.tif$", "", basename(raster_path))  # Obtener el nombre sin extensión
  output_path <- file.path(output_dir, paste0(raster_name, ".asc"))
  
  # Guardar el raster recortado en formato ASCII (.asc)
  writeRaster(raster_recortado, output_path, filetype = "AAIGrid", overwrite = TRUE)
  
  # Mensaje de confirmación
  cat("Guardado:", output_path, "\n")
}


# Nota: como todas las capas recortadas presentaban NA, estas se recortaron directamente en QGIS para evitar este problema con todos los recortes.

raster_dir3 <- "D:/TRABAJOFINAL/CapasBioclimáticas/HOLOCENOMED/Recortadas QGIS/"   # ruta  ala carpeta donde están las capas recortadas .asc

_______________________________________________________________________________________________________________

# ---------- Descargar variables bioclimáticas de Worldclim para el último Máximo Glacial a 2.5 minutos -----------------

install.packages(c("geodata", "archive"))
library(geodata)
library(archive)

#Configurar el directorio de trabajo
setwd("D:/TRABAJOFINAL/CapasBioclimáticas/UMG")

# Definir directorio de descarga
dir.create("D:/TRABAJOFINAL/CapasBioclimáticas/UMG", showWarnings = FALSE)

# Descargar datos del Último Máximo Glacial (LGM) de WorldClim v1.4 con resolución de 2.5 minutos
download.file("https://geodata.ucdavis.edu/climate/cmip5/lgm/melgmbi_2-5m.zip",
              destfile = "bio_LGM.zip", mode = "wb")

# Extraer archivos
archive::archive_extract("bio_LGM.zip", dir = "UMG")

# Listar archivos extraídos
list.files("UMG")

# Cargar raster de una variable bioclimática (por ejemplo, BIO1 - Temperatura media anual)
library(raster)
bio1 <- raster("UMG/melgmbi1.tif")
plot(bio1, main="BIO1 - Temperatura media anual (LGM)")


# ---------- RECORTAR LAS 19 CAPAS DE WORLDCLIM DEL UMG USANDO UN SHAPEFILE --------------

install.packages("terra")
library(terra)
library(sf)

# configurar directorio de trabajo
setwd("D:/TRABAJOFINAL/CapasBioclimáticas/UMG/Recortadas")

# Definir rutas de entrada y salida
raster_dir <- "D:/TRABAJOFINAL/CapasBioclimáticas/UMG/UMG/"  # Carpeta donde están las capas .tif
output_dir <- "D:/TRABAJOFINAL/CapasBioclimáticas/UMG/Recortadas"  # Carpeta donde se guardarán los archivos recortados
shapefile_path <- "D:/TRABAJOFINAL/CapasBioclimáticas/UMG/Norteame_shapefile/northam_bueno.shp"  # Ruta del shapefile

# Cargar el shapefile
vector <- vect(shapefile_path)

# Obtener la lista de archivos raster en la carpeta
raster_files <- list.files(raster_dir, pattern = "\\.tif$", full.names = TRUE)

# Iterar sobre cada capa raster y recortarla con el shapefile
for (raster_path in raster_files) {
  
  # Cargar la capa raster
  raster_layer <- rast(raster_path)
  
  # Asegurar que el shapefile tenga el mismo CRS que el raster
  vector <- project(vector, crs(raster_layer))
  
  # Recortar el raster con el shapefile
  raster_recortado <- crop(raster_layer, vector)  # Recorta la extensión  
  raster_recortado <- mask(raster_recortado, vector)  # Aplica la máscara
  
  # Definir el nombre del archivo de salida
  raster_name <- gsub("\\.tif$", "", basename(raster_path))  # Obtener el nombre sin extensión
  output_path <- file.path(output_dir, paste0(raster_name, ".asc"))
  
  # Guardar el raster recortado en formato ASCII (.asc)
  writeRaster(raster_recortado, output_path, filetype = "AAIGrid", overwrite = TRUE)
  
  # Mensaje de confirmación
  cat("Guardado:", output_path, "\n")
}


# Nota: como todas las capas recortadas presentaban NA, estas se recortaron directamente en QGIS para evitar este problema con todos los recortes.

raster_dir3 <- "D:/TRABAJOFINAL/CapasBioclimáticas/UMG/Recortadas QGIS/"   # ruta  ala carpeta donde están las capas recortadas .asc


________________________________________________________________________________________________________

# -------- Descargar variables bioclimáticas de Worldclim para el último Inter Glacial a 30 segundos --------

install.packages(c("geodata", "archive"))
library(geodata)
library(archive)
library(terra)

#Configurar el directorio de trabajo
setwd("D:/TRABAJOFINAL/CapasBioclimáticas/UIG")

# Definir directorio de descarga
dir.create("D:/TRABAJOFINAL/CapasBioclimáticas/UIG", showWarnings = FALSE)

# Descargar datos del Último Máximo Glacial (LGM) de WorldClim v1.4 con resolución de 2.5 minutos
download.file("https://geodata.ucdavis.edu/climate/worldclim/1_4/grid/pst/lig/lig_30s_bio.zip",
              destfile = "bio_LIG.zip", mode = "wb")

# Extraer archivos
archive::archive_extract("bio_LIG.zip", dir = "UIG")

# Listar archivos extraídos
list.files("UIG")

# Cargar raster de una variable bioclimática.
library(raster)
bio1 <- raster("UIG/lig_30s_bio_1.bil")
plot(bio1, main="BIO1 - Temperatura media anual (LIG)")



# ------------- RECORTAR LAS 19 CAPAS DE WORLDCLIM DEL ÚLTIMO INTER GLACIAL .bil  USANDO UN SHAPEFILE --------------

# Instalar y cargar paquetes necesarios
install.packages("terra", dependencies = TRUE)  # Solo si no tienes 'terra'
library(terra)

# Configurar directorio
setwd("D:/TRABAJOFINAL/CapasBioclimáticas/UIG/Recortadas")

# Rutas de entrada y salida
raster_dir <- "D:/TRABAJOFINAL/CapasBioclimáticas/UIG/UIG"  # Carpeta con archivos .bil
output_dir <- "D:/TRABAJOFINAL/CapasBioclimáticas/UIG/Recortadas"  # Carpeta de salida
shapefile_path <- "D:/TRABAJOFINAL/CapasBioclimáticas/MEX shapefile/mex_adm0.shp"  # Shapefile

# Crear carpeta de salida si no existe
if (!dir.exists(output_dir)) dir.create(output_dir, recursive = TRUE)

# Cargar shapefile
vector <- vect(shapefile_path)

# Verificar CRS del shapefile
print(crs(vector))

# Obtener lista de archivos .bil
raster_files <- list.files(raster_dir, pattern = "\\.bil$", full.names = TRUE)

# Depuración: verificar si encontró archivos
if (length(raster_files) == 0) {
  stop("❌ No se encontraron archivos .bil en la carpeta.")
}

# Iterar sobre cada archivo .bil
for (raster_path in raster_files) {
  cat("\n📌 Procesando:", raster_path, "\n")
  
  # Cargar el raster
  raster_layer <- rast(raster_path)
  
  # Verificar CRS del raster
  print(crs(raster_layer))
  
  # Si el CRS del raster y el shapefile no coinciden, reproyectar el shapefile
  if (!crs(vector) == crs(raster_layer)) {
    cat("⚠️ CRS diferentes, reproyectando shapefile...\n")
    vector <- project(vector, crs(raster_layer))
  }
  
  # Recortar el raster con el shapefile
  raster_crop <- crop(raster_layer, vector)
  raster_mask <- mask(raster_crop, vector)
  
  # Definir nombre del archivo de salida
  raster_name <- tools::file_path_sans_ext(basename(raster_path))  # Nombre sin extensión
  output_path <- file.path(output_dir, paste0(raster_name, ".asc"))
  
  # Guardar el raster recortado en formato ASCII (.asc)
  writeRaster(raster_mask, output_path, filetype = "AAIGrid", overwrite = TRUE)
  
  # Mensaje de confirmación
  cat("✅ Guardado:", output_path, "\n")
}



______________________________________________________________________________________________________________________

# ANÁLISIS DE MODELADO DE NICHO USANDO 19 VARIABLES AMBIENTALES PARA LAS POB. DEL GOLFO DE MÉXICO DE Amazona oratrix.

______________________________________________________________________________________________________________________

# ---------- Leer los avistamientos de Amazona oratrix para el Golfo de México de 1970-2000 de GBIF -----------

install.packages("readr")
library(readr)

archivo <- c("D:/TRABAJOFINAL/Avistamientos/GolfoMexico/golfo_paraMaxEnt.csv") # colocar la ruta de donde se tiene el .csv que se analizará
datos <- read_csv(archivo)

# Informacion de las primeras líneas
head(datos)

#-------------------  ANÁLISIS DE MNE AL PRESENTE USANDO 19 VARIABLES AMBIENTALES --------------------------

# Instalar y cargar librerías necesarias
install.packages(c("dismo", "raster", "sf", "sp"), dependencies = TRUE)
library(dismo)
library(raster)
library(sf)
library(sp)
library(rJava)

# confirurar el directorio de trabajo 
setwd("D:/TRABAJOFINAL/Resultados/Golfo/Presente")

# 1. Cargar las 19 variables bioclimáticas desde el directorio donde las tienes guardadas
bioclim_vars <- stack(list.files("D:/TRABAJOFINAL/CapasBioclimáticas/PRESENTE/Recortadas QGIS/", pattern = ".asc$", full.names = TRUE))

# 2. Cargar los puntos de ocurrencia de la especie (archivo CSV con latitud y longitud)
occ_data <- read.csv("D:/TRABAJOFINAL/Avistamientos/GolfoMexico/golfo_paraMaxEnt.csv")
head(occ_data)  # Muestra las primeras filas
str(occ_data)  # Verifica la estructura del DataFrame

# Convertir a objeto espacial usando sf
occ_data_sf <- st_as_sf(occ_data, coords = c("longitude", "latitude"), crs = 4326)

# 3. Extraer valores ambientales en los puntos de ocurrencia
env_values <- extract(bioclim_vars, st_coordinates(occ_data_sf))

# 4. Configurar parámetros avanzados de MaxEnt
maxent_args <- c(
  "responsecurves=true",            # Crear curvas de respuesta
  "pictures=true",                  # Generar imágenes de predicciones
  "randomseed=true",                 # Usar semilla aleatoria
  "autofeature=true",                # Seleccionar automáticamente las features
  "warnings=true",                   # Mostrar advertencias visuales
  "tooltips=true",                   # Mostrar tooltips en la interfaz
  "writeclampgrid=false",            # NO escribir grid de restricción (clamping)
  "randomtestpoints=10",             # Usar 10% de datos como prueba
  "maximumbackground=10000",         # Máximo de 10,000 puntos de fondo
  "replicates=1",                   # Realizar 1 replicaciones. Ajustar al No. de réplicas deseadas, correrá dependiendo de la cap. de tu computadora.
  "replicatetype=bootstrap",         # Tipo de replicación bootstrap
  "extrapolate=true",                # Permitir extrapolación en proyecciones
  "outputgrids=true",                # Escribir grids de salida
  "writeplotdata=true",              # Escribir datos de gráficos
  "cache=true",                       # Cachear archivos ASCII
  "jackknife=true"                  # Evaluar importancia de variables (jackknife)
)

# 5. Correr el modelo MaxEnt con los parámetros definidos
maxent_model <- maxent(bioclim_vars, st_coordinates(occ_data_sf), args = maxent_args, path = "salida_maxent")

# 6. Evaluar el modelo
print(maxent_model)

# 7. Generar mapa de idoneidad del hábitat
predict_map <- predict(maxent_model, bioclim_vars)

# 8. Visualizar resultados
plot(predict_map, main="Modelo de Nicho Ecológico - Presente")

# Guardar el mapa como imagen
png("nicho_ecologico_maxent_presente.png", width=800, height=600)
plot(predict_map, main="Modelo de Nicho Ecológico - MaxEnt")
dev.off()

# Guardar el mapa en formato .asc
writeRaster(predict_map, filename="modelo_nicho.asc", format="ascii", overwrite=TRUE)


# ------------------- CAMBIAR LOS COLORES AL MAPA ------------------------ 
library(terra)
library(tmap)

# Cargar el raster generado por MaxEnt
mapa <- rast("D:/TRABAJOFINAL/Resultados/Golfo/Presente/modelo_nicho.asc")

# Visualizar con paleta personalizada
tm_shape(mapa) +
  tm_raster(
    style = "fixed",
    breaks = c(0.0, 0.4, 1.0),
    palette = c("#D3D3D3", "#228b22"),  # verde intenso, verde limón
    title = "Probabilidad de presencia PRESENTE"
  ) +
  tm_layout(legend.outside = TRUE)


#  -------------- Ver importancia de variables ------------------

maxent_model@results

#EXTRAER LAS 8 VARIABLES MAS IMPORTANTES
# Convertir los resultados a un data.frame
var_importance <- as.data.frame(maxent_model@results)

# Extraer solo las variables ambientales y sus valores de contribución
var_importance <- var_importance[grep("contribution", rownames(var_importance)), , drop = FALSE]

# Ordenar de mayor a menor contribución
var_importance <- var_importance[order(-var_importance[,1]), , drop = FALSE]

# Seleccionar las 8 más importantes
top_8_vars <- head(var_importance, 8)

# Mostrar las 8 variables más importantes
print(top_8_vars)

#--------------- EXPORTAR ESTAS 8 VARIABLES COMO .PNG ----------------

# Instalar y cargar librerías necesarias
install.packages(c("gridExtra", "grid"))
library(gridExtra)
library(grid)

# Crear una tabla con las 8 variables más importantes
tabla_grafica <- tableGrob(top_8_vars)

# Guardar la tabla como una imagen PNG
png("top_8_variables.png", width = 800, height = 400)
grid.draw(tabla_grafica)  # Dibujar la tabla en la imagen
dev.off()


# ---------------  CALCULAR EL ÁREA OCUPADA en KM2, EN EL PRESENTE ---------------------
# Se asume que el archivo .asc contiene valores de probabilidad de presencia (0-1).
# Se define un umbral para considerar "presencia".

library(raster)

# Directorio de trabajo 
setwd("D:/TRABAJOFINAL/Resultados/Golfo/Presente")

mapa_nicho <- raster("D:/TRABAJOFINAL/Resultados/Golfo/Presente/modelo_nicho.asc")     # ruta a donde esta el archivo .asc generado

# Ver información del raster
print(mapa_nicho)
crs(mapa_nicho)  #Ver la proyección

# Como el mapa tienen una proyección geográfica WGS84, EPSG:4326 "+proj=lonlat", la resolución está en grados y debe convertirse a KM2
# Cargar el raster del modelo de nicho (archivo .asc)
mapa_nicho <- raster("D:/TRABAJOFINAL/Resultados/Golfo/Presente/modelo_nicho.asc")  # Cambia el nombre de tu archivo

# Definir un umbral para considerar "presencia"
umbral <- 0.4 

# Crear un raster binario (1 = presencia, 0 = ausencia)
mapa_binario <- mapa_nicho >= umbral

# Obtener la latitud media del mapa para la conversión de grados a km
lat_media <- mean(extent(mapa_nicho)[c(3,4)])  # Promedio de latitudes min y max

# Convertir resolución de grados a km (1 grado ≈ 111.32 km * cos(latitud))
res_x_km <- xres(mapa_nicho) * 111.32 * cos(lat_media * pi/180)
res_y_km <- yres(mapa_nicho) * 111.32 * cos(lat_media * pi/180)

# Área de cada píxel en km²
area_pixel_km2 <- res_x_km * res_y_km

# Contar los píxeles de presencia (donde el valor es 1)
num_pixeles_presencia <- sum(values(mapa_binario), na.rm = TRUE)

# Calcular el área total ocupada en km²
area_ocupada_km2 <- num_pixeles_presencia * area_pixel_km2

# Mostrar el resultado
print(paste("El área ocupada es de", round(area_ocupada_km2, 2), "km²"))


#-------------------  ANÁLISIS DE MNE AL HOLOCENO USANDO 19 VARIABLES AMBIENTALES GOLFO DE MÉXICO --------------------------

# Instalar y cargar librerías necesarias
install.packages(c("dismo", "raster", "sf", "sp"), dependencies = TRUE)
library(dismo)
library(raster)
library(sf)
library(sp)
library(rJava)

# confirurar el directorio de trabajo 
setwd("D:/TRABAJOFINAL/Resultados/Golfo/Holoceno")

# 1. Cargar las 19 variables bioclimáticas del Holoceno desde el directorio donde las tienes guardadas
bioclim_vars <- stack(list.files("D:/TRABAJOFINAL/CapasBioclimáticas/HOLOCENOMED/Recortadas QGIS/", pattern = ".asc$", full.names = TRUE))

# 2. Cargar los puntos de ocurrencia de la especie (archivo CSV con latitud y longitud)
occ_data <- read.csv("D:/TRABAJOFINAL/Avistamientos/GolfoMexico/golfo_paraMaxEnt.csv")
head(occ_data)  # Muestra las primeras filas
str(occ_data)  # Verifica la estructura del DataFrame

# Convertir a objeto espacial usando sf
occ_data_sf <- st_as_sf(occ_data, coords = c("longitude", "latitude"), crs = 4326)

# 3. Extraer valores ambientales en los puntos de ocurrencia
env_values <- extract(bioclim_vars, st_coordinates(occ_data_sf))

# 4. Configurar parámetros avanzados de MaxEnt
maxent_args <- c(
  "responsecurves=true",            # Crear curvas de respuesta
  "pictures=true",                  # Generar imágenes de predicciones
  "randomseed=true",                 # Usar semilla aleatoria
  "autofeature=true",                # Seleccionar automáticamente las features
  "warnings=true",                   # Mostrar advertencias visuales
  "tooltips=true",                   # Mostrar tooltips en la interfaz
  "writeclampgrid=false",            # NO escribir grid de restricción (clamping)
  "randomtestpoints=10",             # Usar 10% de datos como prueba
  "maximumbackground=10000",         # Máximo de 10,000 puntos de fondo
  "replicates=1",                   # Realizar 1 replicaciones. Ajustar al No. de réplicas deseadas, correrá dependiendo de la cap. de tu computadora.
  "replicatetype=bootstrap",         # Tipo de replicación bootstrap
  "extrapolate=true",                # Permitir extrapolación en proyecciones
  "outputgrids=true",                # Escribir grids de salida
  "writeplotdata=true",              # Escribir datos de gráficos
  "cache=true",                       # Cachear archivos ASCII
  "jackknife=true"                  # Evaluar importancia de variables (jackknife)
)

# 5. Correr el modelo MaxEnt con los parámetros definidos
maxent_model <- maxent(bioclim_vars, st_coordinates(occ_data_sf), args = maxent_args, path = "salida_maxent_holoceno")

# 6. Evaluar el modelo
print(maxent_model)

# 7. Generar mapa de idoneidad del hábitat
predict_map <- predict(maxent_model, bioclim_vars)

# 8. Visualizar resultados
plot(predict_map, main="Modelo de Nicho Ecológico - HOLOCENO")

# Guardar el mapa como imagen
png("nicho_ecologico_maxent1.png", width=800, height=600)
plot(predict_map, main="Modelo de Nicho Ecológico - HOLOCENO MAXENT")
dev.off()

# Guardar el mapa en formato .asc
writeRaster(predict_map, filename="modelo_nicho.asc", format="ascii", overwrite=TRUE)


# -------------------- CAMBIAR LOS COLORES AL MAPA -------------------------- 
library(terra)
library(tmap)

# Cargar el raster generado por MaxEnt
mapa <- rast("D:/TRABAJOFINAL/Resultados/Golfo/Holoceno/modelo_nicho.asc")

# Visualizar con paleta personalizada
tm_shape(mapa) +
  tm_raster(
    style = "fixed",
    breaks = c(0.0, 0.4, 1.0),
    palette = c("#D3D3D3", "#228b22"),  # verde intenso, verde limón
    title = "Probabilidad de presencia HOLOCENO"
  ) +
  tm_layout(legend.outside = TRUE)


# ---------------- CALCULAR EL ÁREA OCUPADA en KM2, EN EL PRESENTE ---------------------

# Se asume que el archivo .asc contiene valores de probabilidad de presencia (0-1).
# Se define un umbral para considerar "presencia".

library(raster)

# Directorio de trabajo 
setwd("D:/TRABAJOFINAL/Resultados/Golfo/Holoceno")

mapa_nicho <- raster("D:/TRABAJOFINAL/Resultados/Golfo/Holoceno/modelo_nicho.asc")

# Ver información del raster
print(mapa_nicho)
crs(mapa_nicho)  #Ver la proyección

# Como el mapa tienen una proyección geográfica WGS84, "+proj=lonlat", la resolución está en grados y debe convertirse a KM2
# Cargar el raster del modelo de nicho (archivo .asc)
mapa_nicho <- raster("D:/TRABAJOFINAL/Resultados/Golfo/Holoceno/modelo_nicho.asc")  # Cambia el nombre de tu archivo

# Definir un umbral para considerar "presencia"
umbral <- 0.4 

# Crear un raster binario (1 = presencia, 0 = ausencia)
mapa_binario <- mapa_nicho >= umbral

# Obtener la latitud media del mapa para la conversión de grados a km
lat_media <- mean(extent(mapa_nicho)[c(3,4)])  # Promedio de latitudes min y max

# Convertir resolución de grados a km (1 grado ≈ 111.32 km * cos(latitud))
res_x_km <- xres(mapa_nicho) * 111.32 * cos(lat_media * pi/180)
res_y_km <- yres(mapa_nicho) * 111.32 * cos(lat_media * pi/180)

# Área de cada píxel en km²
area_pixel_km2 <- res_x_km * res_y_km

# Contar los píxeles de presencia (donde el valor es 1)
num_pixeles_presencia <- sum(values(mapa_binario), na.rm = TRUE)

# Calcular el área total ocupada en km²
area_ocupada_km2 <- num_pixeles_presencia * area_pixel_km2

# Mostrar el resultado
print(paste("El área ocupada es de", round(area_ocupada_km2, 2), "km²"))


#-------------------  ANÁLISIS DE MNE AL ÚLTIMO MÁXIMO GLACIAL USANDO 19 VARIABLES AMBIENTALES PARA EL GOLFO DE MEXICO--------------------------

# Instalar y cargar librerías necesarias
install.packages(c("dismo", "raster", "sf", "sp"), dependencies = TRUE)
library(dismo)
library(raster)
library(sf)
library(sp)
library(rJava)

# confirurar el directorio de trabajo 
setwd("D:/TRABAJOFINAL/Resultados/Golfo/UMG")

# 1. Cargar las 19 variables bioclimáticas del UMG desde el directorio donde las tienes guardadas
bioclim_vars <- stack(list.files("D:/TRABAJOFINAL/CapasBioclimáticas/UMG/Recortadas QGIS/", pattern = ".asc$", full.names = TRUE))

# 2. Cargar los puntos de ocurrencia de la especie (archivo CSV con latitud y longitud)
occ_data <- read.csv("D:/TRABAJOFINAL/Avistamientos/GolfoMexico/golfo_paraMaxEnt.csv")
head(occ_data)  # Muestra las primeras filas
str(occ_data)  # Verifica la estructura del DataFrame

# Convertir a objeto espacial usando sf
occ_data_sf <- st_as_sf(occ_data, coords = c("longitude", "latitude"), crs = 4326)

# 3. Extraer valores ambientales en los puntos de ocurrencia
env_values <- extract(bioclim_vars, st_coordinates(occ_data_sf))

# 4. Configurar parámetros avanzados de MaxEnt
maxent_args <- c(
  "responsecurves=true",            # Crear curvas de respuesta
  "pictures=true",                  # Generar imágenes de predicciones
  "randomseed=true",                 # Usar semilla aleatoria
  "autofeature=true",                # Seleccionar automáticamente las features
  "warnings=true",                   # Mostrar advertencias visuales
  "tooltips=true",                   # Mostrar tooltips en la interfaz
  "writeclampgrid=false",            # NO escribir grid de restricción (clamping)
  "randomtestpoints=10",             # Usar 10% de datos como prueba
  "maximumbackground=10000",         # Máximo de 10,000 puntos de fondo
  "replicates=1",                   # Realizar 1 replicaciones. Ajustar al No. de réplicas deseadas, correrá dependiendo de la cap. de tu computadora.
  "replicatetype=bootstrap",         # Tipo de replicación bootstrap
  "extrapolate=true",                # Permitir extrapolación en proyecciones
  "outputgrids=true",                # Escribir grids de salida
  "writeplotdata=true",              # Escribir datos de gráficos
  "cache=true",                       # Cachear archivos ASCII
  "jackknife=true"                  # Evaluar importancia de variables (jackknife)
)

# 5. Correr el modelo MaxEnt con los parámetros definidos
maxent_model <- maxent(bioclim_vars, st_coordinates(occ_data_sf), args = maxent_args, path ="Salida_UMG")

# 6. Evaluar el modelo
print(maxent_model)

# 7. Generar mapa de idoneidad del hábitat
predict_map <- predict(maxent_model, bioclim_vars)

# 8. Visualizar resultados
plot(predict_map, main="Modelo de Nicho Ecológico - UMG")

# Guardar el mapa como imagen
png("nicho_ecologico_maxent1.png", width=800, height=600)
plot(predict_map, main="Modelo de Nicho Ecológico - UMG MAXENT")
dev.off()

# Guardar el mapa en formato .asc
writeRaster(predict_map, filename="modelo_nicho.asc", format="ascii", overwrite=TRUE)


# ------------------------------- CAMBIAR LOS COLORES AL MAPA ---------------------------------

library(terra)
library(tmap)

# Cargar el raster generado por MaxEnt
mapa <- rast("D:/TRABAJOFINAL/Resultados/Golfo/UMG/modelo_nicho.asc")

# Visualizar con paleta personalizada
tm_shape(mapa) +
  tm_raster(
    style = "fixed",
    breaks = c(0.0, 0.4, 1.0),
    palette = c("#D3D3D3", "#228b22"),  # verde intenso, verde limón
    title = "Probabilidad de presencia UMG"
  ) +
  tm_layout(legend.outside = TRUE)


# ---------------------------- CALCULAR EL ÁREA OCUPADA en KM2, EN EL PRESENTE ------------------------------------
# Se asume que el archivo .asc contiene valores de probabilidad de presencia (0-1).
# Se define un umbral para considerar "presencia".

library(raster)

# Directorio de trabajo 
setwd("D:/TRABAJOFINAL/Resultados/Golfo/UMG/")

mapa_nicho <- raster("D:/TRABAJOFINAL/Resultados/Golfo/UMG/modelo_nicho.asc")

# Ver información del raster
print(mapa_nicho)
crs(mapa_nicho)  #Ver la proyección

# Como el mapa tienen una proyección geográfica WGS84,"+proj=lonlat", la resolución está en grados y debe convertirse a KM2
# Cargar el raster del modelo de nicho (archivo .asc)
mapa_nicho <- raster("D:/TRABAJOFINAL/Resultados/Golfo/UMG/modelo_nicho.asc")  # Cambia el nombre de tu archivo

# Definir un umbral para considerar "presencia"
umbral <- 0.4 

# Crear un raster binario (1 = presencia, 0 = ausencia)
mapa_binario <- mapa_nicho >= umbral

# Obtener la latitud media del mapa para la conversión de grados a km
lat_media <- mean(extent(mapa_nicho)[c(3,4)])  # Promedio de latitudes min y max

# Convertir resolución de grados a km (1 grado ≈ 111.32 km * cos(latitud))
res_x_km <- xres(mapa_nicho) * 111.32 * cos(lat_media * pi/180)
res_y_km <- yres(mapa_nicho) * 111.32 * cos(lat_media * pi/180)

# Área de cada píxel en km²
area_pixel_km2 <- res_x_km * res_y_km

# Contar los píxeles de presencia (donde el valor es 1)
num_pixeles_presencia <- sum(values(mapa_binario), na.rm = TRUE)

# Calcular el área total ocupada en km²
area_ocupada_km2 <- num_pixeles_presencia * area_pixel_km2

# Mostrar el resultado
print(paste("El área ocupada es de", round(area_ocupada_km2, 2), "km²"))


#-------------------  ANÁLISIS DE MNE AL ÚLTIMO INTER GLACIAL USANDO 19 VARIABLES AMBIENTALES PARA EL GOLFO DE MEXICO--------------------------

# Instalar y cargar librerías necesarias
install.packages(c("dismo", "raster", "sf", "sp"), dependencies = TRUE)
library(dismo)
library(raster)
library(sf)
library(sp)
library(rJava)

# confirurar el directorio de trabajo 
setwd("D:/TRABAJOFINAL/Resultados/Golfo/UIG/")

# 1. Cargar las 19 variables bioclimáticas del UIG desde el directorio donde las tienes guardadas
bioclim_vars <- stack(list.files("D:/TRABAJOFINAL/CapasBioclimáticas/UIG/Recortadas/", pattern = ".asc$", full.names = TRUE))

# 2. Cargar los puntos de ocurrencia de la especie (archivo CSV con latitud y longitud)
occ_data <- read.csv("D:/TRABAJOFINAL/Avistamientos/GolfoMexico/golfo_paraMaxEnt.csv")
head(occ_data)  # Muestra las primeras filas
str(occ_data)  # Verifica la estructura del DataFrame

# Convertir a objeto espacial usando sf
occ_data_sf <- st_as_sf(occ_data, coords = c("longitude", "latitude"), crs = 4326)

# 3. Extraer valores ambientales en los puntos de ocurrencia
env_values <- extract(bioclim_vars, st_coordinates(occ_data_sf))

# 4. Configurar parámetros avanzados de MaxEnt
maxent_args <- c(
  "responsecurves=true",            # Crear curvas de respuesta
  "pictures=true",                  # Generar imágenes de predicciones
  "randomseed=true",                 # Usar semilla aleatoria
  "autofeature=true",                # Seleccionar automáticamente las features
  "warnings=true",                   # Mostrar advertencias visuales
  "tooltips=true",                   # Mostrar tooltips en la interfaz
  "writeclampgrid=false",            # NO escribir grid de restricción (clamping)
  "randomtestpoints=10",             # Usar 10% de datos como prueba
  "maximumbackground=10000",         # Máximo de 10,000 puntos de fondo
  "replicates=1",                   # Realizar 1 replicaciones. Ajustar al No. de réplicas deseadas, correrá dependiendo de la cap. de tu computadora.
  "replicatetype=bootstrap",         # Tipo de replicación bootstrap
  "extrapolate=true",                # Permitir extrapolación en proyecciones
  "outputgrids=true",                # Escribir grids de salida
  "writeplotdata=true",              # Escribir datos de gráficos
  "cache=true",                       # Cachear archivos ASCII
  "jackknife=true"                  # Evaluar importancia de variables (jackknife)
)

# 5. Correr el modelo MaxEnt con los parámetros definidos
maxent_model <- maxent(bioclim_vars, st_coordinates(occ_data_sf), args = maxent_args, path = "salida_maxent_UIG")

# 6. Evaluar el modelo
print(maxent_model)

# 7. Generar mapa de idoneidad del hábitat
predict_map <- predict(maxent_model, bioclim_vars)

# 8. Visualizar resultados
plot(predict_map, main="Modelo de Nicho Ecológico - UIG")

# Guardar el mapa como imagen
png("nicho_ecologico_maxent1.png", width=800, height=600)
plot(predict_map, main="Modelo de Nicho Ecológico - UIG MAXENT")
dev.off()

# Guardar el mapa en formato .asc
writeRaster(predict_map, filename="modelo_nicho.asc", format="ascii", overwrite=TRUE)


# -----------------  CAMBIAR LOS COLORES AL MAPA -------------------------- 
library(terra)
library(tmap)

# Cargar el raster generado por MaxEnt
mapa <- rast("D:/TRABAJOFINAL/Resultados/Golfo/UIG/modelo_nicho.asc")

# Visualizar con paleta personalizada
tm_shape(mapa) +
  tm_raster(
    style = "fixed",
    breaks = c(0.0, 0.4, 1.0),
    palette = c("#D3D3D3", "#228b22"),  # verde intenso, verde limón
    title = "Probabilidad de presencia UIG"
  ) +
  tm_layout(legend.outside = TRUE)


# ------------------------   CALCULAR EL ÁREA OCUPADA en KM2, EN EL UIG  ---------------------------------
# Se asume que el archivo .asc contiene valores de probabilidad de presencia (0-1).
# Se define un umbral para considerar "presencia".

library(raster)

# Directorio de trabajo 
setwd("D:/TRABAJOFINAL/Resultados/Golfo/UIG")

#Cargar el mapa .asc generado para el UIG
mapa_nicho <- raster("D:/TRABAJOFINAL/Resultados/Golfo/UIG/modelo_nicho.asc")

# Ver información del raster
print(mapa_nicho)
crs(mapa_nicho)  #Ver la proyección

# Como el mapa tienen una proyección geográfica WGS84,"+proj=lonlat", la resolución está en grados y debe convertirse a KM2
# Cargar el raster del modelo de nicho (archivo .asc)
mapa_nicho <- raster("D:/TRABAJOFINAL/Resultados/Golfo/UIG/modelo_nicho.asc")  # Cambia el nombre de tu archivo

# Definir un umbral para considerar "presencia"
umbral <- 0.4 

# Crear un raster binario (1 = presencia, 0 = ausencia)
mapa_binario <- mapa_nicho >= umbral

# Obtener la latitud media del mapa para la conversión de grados a km
lat_media <- mean(extent(mapa_nicho)[c(3,4)])  # Promedio de latitudes min y max

# Convertir resolución de grados a km (1 grado ≈ 111.32 km * cos(latitud))
res_x_km <- xres(mapa_nicho) * 111.32 * cos(lat_media * pi/180)
res_y_km <- yres(mapa_nicho) * 111.32 * cos(lat_media * pi/180)

# Área de cada píxel en km²
area_pixel_km2 <- res_x_km * res_y_km

# Contar los píxeles de presencia (donde el valor es 1)
num_pixeles_presencia <- sum(values(mapa_binario), na.rm = TRUE)

# Calcular el área total ocupada en km²
area_ocupada_km2 <- num_pixeles_presencia * area_pixel_km2

# Mostrar el resultado
print(paste("El área ocupada es de", round(area_ocupada_km2, 2), "km²"))


_________________________________________________________________________________________________________________

# ANÁLISIS DE MODELADO DE NICHO USANDO 19 VARIABLES AMBIENTALES PARA LAS POB. DEL PACÍFICO DE Amazona oratrix.

________________________________________________________________________________________________________________

# ---------- Leer los avistamientos de Amazona oratrix para el Pacífico de 1970-2000 de GBIF -----------

install.packages("readr")
library(readr)

archivo <- c("D:/TRABAJOFINAL/Avistamientos/Pacífico/Pacífico_paraMaxEnt.csv")      # colocar la ruta de donde se tiene el .csv que se analizará
datos <- read_csv(archivo)

# Informacion de las primeras líneas
head(datos)


#-------------------  ANÁLISIS DE MNE AL PRESENTE USANDO 19 VARIABLES AMBIENTALES EN EL PRESENTE --------------------------

# Instalar y cargar librerías necesarias
install.packages(c("dismo", "raster", "sf", "sp"), dependencies = TRUE)
library(dismo)
library(raster)
library(sf)
library(sp)
library(rJava)

# confirurar el directorio de trabajo 
setwd("D:/TRABAJOFINAL/Resultados/Pacifico/Presente")

# 1. Cargar las 19 variables bioclimáticas desde el directorio donde las tienes guardadas
bioclim_vars <- stack(list.files("D:/TRABAJOFINAL/CapasBioclimáticas/PRESENTE/Recortadas QGIS/", pattern = ".asc$", full.names = TRUE))

# 2. Cargar los puntos de ocurrencia de la especie (archivo CSV con latitud y longitud)
occ_data <- read.csv("D:/TRABAJOFINAL/Avistamientos/Pacífico/Pacífico_paraMaxEnt.csv")
head(occ_data)  # Muestra las primeras filas
str(occ_data)  # Verifica la estructura del DataFrame

# Convertir a objeto espacial usando sf
occ_data_sf <- st_as_sf(occ_data, coords = c("longitude", "latitude"), crs = 4326)

# 3. Extraer valores ambientales en los puntos de ocurrencia
env_values <- extract(bioclim_vars, st_coordinates(occ_data_sf))

# 4. Configurar parámetros avanzados de MaxEnt
maxent_args <- c(
  "responsecurves=true",            # Crear curvas de respuesta
  "pictures=true",                  # Generar imágenes de predicciones
  "randomseed=true",                 # Usar semilla aleatoria
  "autofeature=true",                # Seleccionar automáticamente las features
  "warnings=true",                   # Mostrar advertencias visuales
  "tooltips=true",                   # Mostrar tooltips en la interfaz
  "writeclampgrid=false",            # NO escribir grid de restricción (clamping)
  "randomtestpoints=10",             # Usar 10% de datos como prueba
  "maximumbackground=10000",         # Máximo de 10,000 puntos de fondo
  "replicates=1",                   # Realizar 1 replicaciones. Ajustar al No. de réplicas deseadas, correrá dependiendo de la cap. de tu computadora.
  "replicatetype=bootstrap",         # Tipo de replicación bootstrap
  "extrapolate=true",                # Permitir extrapolación en proyecciones
  "outputgrids=true",                # Escribir grids de salida
  "writeplotdata=true",              # Escribir datos de gráficos
  "cache=true",                       # Cachear archivos ASCII
  "jackknife=true"                  # Evaluar importancia de variables (jackknife)
)

# 5. Correr el modelo MaxEnt con los parámetros definidos
maxent_model <- maxent(bioclim_vars, st_coordinates(occ_data_sf), args = maxent_args, path = "salida_pacífico")

# 6. Evaluar el modelo
print(maxent_model)

# 7. Generar mapa de idoneidad del hábitat
predict_map <- predict(maxent_model, bioclim_vars)

# 8. Visualizar resultados
plot(predict_map, main="Modelo de Nicho Ecológico - Pacífico")

# Guardar el mapa como imagen
png("nicho_ecologico_pacífico.png", width=800, height=600)
plot(predict_map, main="Modelo de Nicho Ecológico - MaxEnt")
dev.off()

# Guardar el mapa en formato .asc
writeRaster(predict_map, filename="modelo_nicho.asc", format="ascii", overwrite=TRUE)


# ------------------------    CAMBIAR LOS COLORES AL MAPA  ------------------------------- 
library(terra)
library(tmap)

# Cargar el raster generado por MaxEnt
mapa <- rast("D:/TRABAJOFINAL/Resultados/Pacifico/Presente/modelo_nicho.asc")

# Visualizar con paleta personalizada
tm_shape(mapa) +
  tm_raster(
    style = "fixed",
    breaks = c(0.0, 0.4, 1.0),
    palette = c("#D3D3D3", "#228b22"),  # verde intenso, verde limón
    title = "Probabilidad de presencia PRESENTE"
  ) +
  tm_layout(legend.outside = TRUE)


#  -----------------------------   Ver importancia de variables ----------------------------
maxent_model@results

#----------------------------EXTRAER LAS 8 VARIABLES MÁS IMPORTANTES -----------------------
# Convertir los resultados a un data.frame
var_importance <- as.data.frame(maxent_model@results)

# Extraer solo las variables ambientales y sus valores de contribución
var_importance <- var_importance[grep("contribution", rownames(var_importance)), , drop = FALSE]

# Ordenar de mayor a menor contribución
var_importance <- var_importance[order(-var_importance[,1]), , drop = FALSE]

# Seleccionar las 8 más importantes
top_8_vars <- head(var_importance, 8)

# Mostrar las 8 variables más importantes
print(top_8_vars)

# ---------------------------------   EXPORTAR ESTAS 8 VARIABLES COMO .PNG   ------------------------

# Instalar y cargar librerías necesarias
install.packages(c("gridExtra", "grid"))
library(gridExtra)
library(grid)

# Crear una tabla con las 8 variables más importantes
tabla_grafica <- tableGrob(top_8_vars)

# Guardar la tabla como una imagen PNG
png("top_8_variables.png", width = 800, height = 400)
grid.draw(tabla_grafica)  # Dibujar la tabla en la imagen
dev.off()


# ----------------------------   CALCULAR EL ÁREA OCUPADA en KM2, EN EL PRESENTE   ------------------------------
# Se asume que el archivo .asc contiene valores de probabilidad de presencia (0-1).
# Se define un umbral para considerar "presencia".

library(raster)

# Directorio de trabajo 
setwd("D:/TRABAJOFINAL/Resultados/Pacifico/Presente/")

#Cargar el mapa .asc 
mapa_nicho <- raster("D:/TRABAJOFINAL/Resultados/Pacifico/Presente/modelo_nicho.asc")

# Ver información del raster
print(mapa_nicho)
crs(mapa_nicho)  #Ver la proyección

# Como el mapa tienen una proyección geográfica WGS84,"+proj=lonlat", la resolución está en grados y debe convertirse a KM2
# Cargar el raster del modelo de nicho (archivo .asc)
mapa_nicho <- raster("D:/TRABAJOFINAL/Resultados/Pacifico/Presente/modelo_nicho.asc")  # Cambia el nombre de tu archivo

# Definir un umbral para considerar "presencia"
umbral <- 0.4 

# Crear un raster binario (1 = presencia, 0 = ausencia)
mapa_binario <- mapa_nicho >= umbral

# Obtener la latitud media del mapa para la conversión de grados a km
lat_media <- mean(extent(mapa_nicho)[c(3,4)])  # Promedio de latitudes min y max

# Convertir resolución de grados a km (1 grado ≈ 111.32 km * cos(latitud))
res_x_km <- xres(mapa_nicho) * 111.32 * cos(lat_media * pi/180)
res_y_km <- yres(mapa_nicho) * 111.32 * cos(lat_media * pi/180)

# Área de cada píxel en km²
area_pixel_km2 <- res_x_km * res_y_km

# Contar los píxeles de presencia (donde el valor es 1)
num_pixeles_presencia <- sum(values(mapa_binario), na.rm = TRUE)

# Calcular el área total ocupada en km²
area_ocupada_km2 <- num_pixeles_presencia * area_pixel_km2

# Mostrar el resultado
print(paste("El área ocupada es de", round(area_ocupada_km2, 2), "km²"))


#-------------------  ANÁLISIS DE MNE AL HOLOCENO USANDO 19 VARIABLES AMBIENTALES PARA EL PACÍFICO --------------------------

# Instalar y cargar librerías necesarias
install.packages(c("dismo", "raster", "sf", "sp"), dependencies = TRUE)
library(dismo)
library(raster)
library(sf)
library(sp)
library(rJava)

# confirurar el directorio de trabajo 
setwd("D:/TRABAJOFINAL/Resultados/Pacifico/Holoceno")

## 1. Cargar las 19 variables bioclimáticas del Holoceno desde el directorio donde las tienes guardadas
bioclim_vars <- stack(list.files("D:/TRABAJOFINAL/CapasBioclimáticas/HOLOCENOMED/Recortadas QGIS/", pattern = ".asc$", full.names = TRUE))

# 2. Cargar los puntos de ocurrencia de la especie (archivo CSV con latitud y longitud)
occ_data <- read.csv("D:/TRABAJOFINAL/Avistamientos/Pacífico/Pacífico_paraMaxEnt.csv")
head(occ_data)  # Muestra las primeras filas
str(occ_data)  # Verifica la estructura del DataFrame

# Convertir a objeto espacial usando sf
occ_data_sf <- st_as_sf(occ_data, coords = c("longitude", "latitude"), crs = 4326)

# 3. Extraer valores ambientales en los puntos de ocurrencia
env_values <- extract(bioclim_vars, st_coordinates(occ_data_sf))

# 4. Configurar parámetros avanzados de MaxEnt
maxent_args <- c(
  "responsecurves=true",            # Crear curvas de respuesta
  "pictures=true",                  # Generar imágenes de predicciones
  "randomseed=true",                 # Usar semilla aleatoria
  "autofeature=true",                # Seleccionar automáticamente las features
  "warnings=true",                   # Mostrar advertencias visuales
  "tooltips=true",                   # Mostrar tooltips en la interfaz
  "writeclampgrid=false",            # NO escribir grid de restricción (clamping)
  "randomtestpoints=10",             # Usar 10% de datos como prueba
  "maximumbackground=10000",         # Máximo de 10,000 puntos de fondo
  "replicates=1",                   # Realizar 1 replicaciones. Ajustar al No. de réplicas deseadas, correrá dependiendo de la cap. de tu computadora.
  "replicatetype=bootstrap",         # Tipo de replicación bootstrap
  "extrapolate=true",                # Permitir extrapolación en proyecciones
  "outputgrids=true",                # Escribir grids de salida
  "writeplotdata=true",              # Escribir datos de gráficos
  "cache=true",                       # Cachear archivos ASCII
  "jackknife=true"                  # Evaluar importancia de variables (jackknife)
)

# 5. Correr el modelo MaxEnt con los parámetros definidos
maxent_model <- maxent(bioclim_vars, st_coordinates(occ_data_sf), args = maxent_args, path = "Salida")

# 6. Evaluar el modelo
print(maxent_model)

# 7. Generar mapa de idoneidad del hábitat
predict_map <- predict(maxent_model, bioclim_vars)

# 8. Visualizar resultados
plot(predict_map, main="Modelo de Nicho Ecológico - HOLOCENO")

# Guardar el mapa como imagen
png("nicho_ecologico_maxent1.png", width=800, height=600)
plot(predict_map, main="Modelo de Nicho Ecológico - HOLOCENO MAXENT")
dev.off()

# Guardar el mapa en formato .asc
writeRaster(predict_map, filename="modelo_nicho.asc", format="ascii", overwrite=TRUE)


# --------------------   CAMBIAR LOS COLORES AL MAPA  ----------------------------------- 
library(terra)
library(tmap)

# Cargar el raster generado por MaxEnt
mapa <- rast("D:/TRABAJOFINAL/Resultados/Pacifico/Holoceno/modelo_nicho.asc")

# Visualizar con paleta personalizada
tm_shape(mapa) +
  tm_raster(
    style = "fixed",
    breaks = c(0.0, 0.4, 1.0),
    palette = c("#D3D3D3", "#228b22"),  # verde intenso, verde limón
    title = "Probabilidad de presencia Holoceno"
  ) +
  tm_layout(legend.outside = TRUE)


# -------------------------  CALCULAR EL AREA OCUPADA en KM2 EN EL Holoceno ----------------------------------
# Se asume que el archivo .asc contiene valores de probabilidad de presencia (0-1).
# Se define un umbral para considerar "presencia".

library(raster)

# Directorio de trabajo 
setwd("D:/TRABAJOFINAL/Resultados/Pacifico/Holoceno/")

#Cargar el mapa .asc
mapa_nicho <- raster("D:/TRABAJOFINAL/Resultados/Pacifico/Holoceno/modelo_nicho.asc")

# Ver información del raster
print(mapa_nicho)
crs(mapa_nicho)  #Ver la proyección

# Como el mapa tienen una proyección geográfica WGS84, "+proj=lonlat", la resolución está en grados y debe convertirse a KM2
# Cargar el raster del modelo de nicho (archivo .asc)
mapa_nicho <- raster("D:/TRABAJOFINAL/Resultados/Pacifico/Holoceno/modelo_nicho.asc")  # Cambia el nombre de tu archivo

# Definir un umbral para considerar "presencia"
umbral <- 0.4 

# Crear un raster binario (1 = presencia, 0 = ausencia)
mapa_binario <- mapa_nicho >= umbral

# Obtener la latitud media del mapa para la conversión de grados a km
lat_media <- mean(extent(mapa_nicho)[c(3,4)])  # Promedio de latitudes min y max

# Convertir resolución de grados a km (1 grado ≈ 111.32 km * cos(latitud))
res_x_km <- xres(mapa_nicho) * 111.32 * cos(lat_media * pi/180)
res_y_km <- yres(mapa_nicho) * 111.32 * cos(lat_media * pi/180)

# Área de cada píxel en km²
area_pixel_km2 <- res_x_km * res_y_km

# Contar los píxeles de presencia (donde el valor es 1)
num_pixeles_presencia <- sum(values(mapa_binario), na.rm = TRUE)

# Calcular el área total ocupada en km²
area_ocupada_km2 <- num_pixeles_presencia * area_pixel_km2

# Mostrar el resultado
print(paste("El área ocupada es de", round(area_ocupada_km2, 2), "km²"))


#-------------------  ANÁLISIS DE MNE AL ÚLTIMO MAXIMO GLACIAL USANDO 19 VARIABLES AMBIENTALES PARA EL PACÍFICO--------------------------

# Instalar y cargar librerías necesarias
install.packages(c("dismo", "raster", "sf", "sp"), dependencies = TRUE)
library(dismo)
library(raster)
library(sf)
library(sp)
library(rJava)

# confirurar el directorio de trabajo 
setwd("D:/TRABAJOFINAL/Resultados/Pacifico/UMG")

# 1. Cargar las 19 variables bioclimáticas del UMG desde el directorio donde las tienes guardadas
bioclim_vars <- stack(list.files("D:/TRABAJOFINAL/CapasBioclimáticas/UMG/Recortadas QGIS/", pattern = ".asc$", full.names = TRUE))

# 2. Cargar los puntos de ocurrencia de la especie (archivo CSV con latitud y longitud)
occ_data <- read.csv("D:/TRABAJOFINAL/Avistamientos/Pacífico/Pacífico_paraMaxEnt.csv")
head(occ_data)  # Muestra las primeras filas
str(occ_data)  # Verifica la estructura del DataFrame

# Convertir a objeto espacial usando sf
occ_data_sf <- st_as_sf(occ_data, coords = c("longitude", "latitude"), crs = 4326)

# 3. Extraer valores ambientales en los puntos de ocurrencia
env_values <- extract(bioclim_vars, st_coordinates(occ_data_sf))

# 4. Configurar parámetros avanzados de MaxEnt
maxent_args <- c(
  "responsecurves=true",            # Crear curvas de respuesta
  "pictures=true",                  # Generar imágenes de predicciones
  "randomseed=true",                 # Usar semilla aleatoria
  "autofeature=true",                # Seleccionar automáticamente las features
  "warnings=true",                   # Mostrar advertencias visuales
  "tooltips=true",                   # Mostrar tooltips en la interfaz
  "writeclampgrid=false",            # NO escribir grid de restricción (clamping)
  "randomtestpoints=10",             # Usar 10% de datos como prueba
  "maximumbackground=10000",         # Máximo de 10,000 puntos de fondo
  "replicates=1",                   # Realizar 1 replicaciones. Ajustar al No. de réplicas deseadas, correrá dependiendo de la cap. de tu computadora.
  "replicatetype=bootstrap",         # Tipo de replicación bootstrap
  "extrapolate=true",                # Permitir extrapolación en proyecciones
  "outputgrids=true",                # Escribir grids de salida
  "writeplotdata=true",              # Escribir datos de gráficos
  "cache=true",                       # Cachear archivos ASCII
  "jackknife=true"                  # Evaluar importancia de variables (jackknife)
)

# 5. Correr el modelo MaxEnt con los parámetros definidos
maxent_model <- maxent(bioclim_vars, st_coordinates(occ_data_sf), args = maxent_args, path = "Salida_UMG")

# 6. Evaluar el modelo
print(maxent_model)

# 7. Generar mapa de idoneidad del hábitat
predict_map <- predict(maxent_model, bioclim_vars)

# 8. Visualizar resultados
plot(predict_map, main="Modelo de Nicho Ecológico - UMG")

# Guardar el mapa como imagen
png("nicho_ecologico_maxent1.png", width=800, height=600)
plot(predict_map, main="Modelo de Nicho Ecológico - UMG MAXENT")
dev.off()

# Guardar el mapa en formato .asc
writeRaster(predict_map, filename="modelo_nicho.asc", format="ascii", overwrite=TRUE)


# --------------------------------- CAMBIAR LOS COLORES AL MAPA --------------------------- 
library(terra)
library(tmap)

# Cargar el raster generado por MaxEnt como .asc
mapa <- rast("D:/TRABAJOFINAL/Resultados/Pacifico/UMG/modelo_nicho.asc")

# Visualizar con paleta personalizada
tm_shape(mapa) +
  tm_raster(
    style = "fixed",
    breaks = c(0.0, 0.4, 1.0),
    palette = c("#D3D3D3", "#228b22"),  # verde intenso, verde limón
    title = "Probabilidad de presencia UMG"
  ) +
  tm_layout(legend.outside = TRUE)


# ------------------------------- CALCULAR EL ÁREA OCUPADA en KM2 EN EL UMG ----------------------------
# Se asume que el archivo .asc contiene valores de probabilidad de presencia (0-1).
# Se define un umbral para considerar "presencia".

library(raster)

# Directorio de trabajo 
setwd("D:/TRABAJOFINAL/Resultados/Pacifico/UMG/")

# Cargar el mapa .asc
mapa_nicho <- raster("D:/TRABAJOFINAL/Resultados/Pacifico/UMG/modelo_nicho.asc")

# Ver información del raster
print(mapa_nicho)
crs(mapa_nicho)  #Ver la proyección

# Como el mapa tienen una proyección geográfica WGS84,"+proj=lonlat", la resolución está en grados y debe convertirse a KM2
# Cargar el raster del modelo de nicho (archivo .asc)
mapa_nicho <- raster("D:/TRABAJOFINAL/Resultados/Pacifico/UMG/modelo_nicho.asc")  # Cambia el nombre de tu archivo

# Definir un umbral para considerar "presencia"
umbral <- 0.4 

# Crear un raster binario (1 = presencia, 0 = ausencia)
mapa_binario <- mapa_nicho >= umbral

# Obtener la latitud media del mapa para la conversión de grados a km
lat_media <- mean(extent(mapa_nicho)[c(3,4)])  # Promedio de latitudes min y max

# Convertir resolución de grados a km (1 grado ≈ 111.32 km * cos(latitud))
res_x_km <- xres(mapa_nicho) * 111.32 * cos(lat_media * pi/180)
res_y_km <- yres(mapa_nicho) * 111.32 * cos(lat_media * pi/180)

# Área de cada píxel en km²
area_pixel_km2 <- res_x_km * res_y_km

# Contar los píxeles de presencia (donde el valor es 1)
num_pixeles_presencia <- sum(values(mapa_binario), na.rm = TRUE)

# Calcular el área total ocupada en km²
area_ocupada_km2 <- num_pixeles_presencia * area_pixel_km2

# Mostrar el resultado
print(paste("El área ocupada es de", round(area_ocupada_km2, 2), "km²"))


#-------------------  ANÁLISIS DE MNE AL ÚLTIMO INTER GLACIAL USANDO 19 VARIABLES AMBIENTALES PARA EL UIG--------------------------

# Instalar y cargar librerías necesarias
install.packages(c("dismo", "raster", "sf", "sp"), dependencies = TRUE)
library(dismo)
library(raster)
library(sf)
library(sp)
library(rJava)

# confirurar el directorio de trabajo 
setwd("D:/TRABAJOFINAL/Resultados/Pacifico/UIG/")

# 1. Cargar las 19 variables bioclimáticas del UMG desde el directorio donde las tienes guardadas
bioclim_vars <- stack(list.files("D:/TRABAJOFINAL/CapasBioclimáticas/UIG/Recortadas/", pattern = ".asc$", full.names = TRUE))

# 2. Cargar los puntos de ocurrencia de la especie (archivo CSV con latitud y longitud)
occ_data <- read.csv("D:/TRABAJOFINAL/Avistamientos/Pacífico/Pacífico_paraMaxEnt.csv")
head(occ_data)  # Muestra las primeras filas
str(occ_data)  # Verifica la estructura del DataFrame

# Convertir a objeto espacial usando sf
occ_data_sf <- st_as_sf(occ_data, coords = c("longitude", "latitude"), crs = 4326)

# 3. Extraer valores ambientales en los puntos de ocurrencia
env_values <- extract(bioclim_vars, st_coordinates(occ_data_sf))

# 4. Configurar parámetros avanzados de MaxEnt
maxent_args <- c(
  "responsecurves=true",            # Crear curvas de respuesta
  "pictures=true",                  # Generar imágenes de predicciones
  "randomseed=true",                 # Usar semilla aleatoria
  "autofeature=true",                # Seleccionar automáticamente las features
  "warnings=true",                   # Mostrar advertencias visuales
  "tooltips=true",                   # Mostrar tooltips en la interfaz
  "writeclampgrid=false",            # NO escribir grid de restricción (clamping)
  "randomtestpoints=10",             # Usar 10% de datos como prueba
  "maximumbackground=10000",         # Máximo de 10,000 puntos de fondo
  "replicates=1",                   # Realizar 1 replicaciones. Ajustar al No. de réplicas deseadas, correrá dependiendo de la cap. de tu computadora.
  "replicatetype=bootstrap",         # Tipo de replicación bootstrap
  "extrapolate=true",                # Permitir extrapolación en proyecciones
  "outputgrids=true",                # Escribir grids de salida
  "writeplotdata=true",              # Escribir datos de gráficos
  "cache=true",                       # Cachear archivos ASCII
  "jackknife=true"                  # Evaluar importancia de variables (jackknife)
)

# 5. Correr el modelo MaxEnt con los parámetros definidos
maxent_model <- maxent(bioclim_vars, st_coordinates(occ_data_sf), args = maxent_args, path = "Salida_UIG")

# 6. Evaluar el modelo
print(maxent_model)

# 7. Generar mapa de idoneidad del hábitat
predict_map <- predict(maxent_model, bioclim_vars)

# 8. Visualizar resultados
plot(predict_map, main="Modelo de Nicho Ecológico - UIG")

# Guardar el mapa como imagen
png("nicho_ecologico_maxent1.png", width=800, height=600)
plot(predict_map, main="Modelo de Nicho Ecológico - UIG MAXENT")
dev.off()

# Guardar el mapa en formato .asc
writeRaster(predict_map, filename="modelo_nicho.asc", format="ascii", overwrite=TRUE)


# ---------------------------- CAMBIAR LOS COLORES AL MAPA ------------------------------------- 
library(terra)
library(tmap)

# Cargar el raster generado por MaxEnt
mapa <- rast("D:/TRABAJOFINAL/Resultados/Pacifico/UIG/modelo_nicho.asc")

# Visualizar con paleta personalizada
tm_shape(mapa) +
  tm_raster(
    style = "fixed",
    breaks = c(0.0, 0.4, 1.0),
    palette = c("#D3D3D3", "#228b22"),  # verde intenso, verde limón
    title = "Probabilidad de presencia UIG"
  ) +
  tm_layout(legend.outside = TRUE)


# -------------------------- CALCULAR EL ÁREA OCUPADA en KM2 PARA EL UIG -------------------------------------
# Se asume que el archivo .asc contiene valores de probabilidad de presencia (0-1).
# Se define un umbral para considerar "presencia".

library(raster)

# Directorio de trabajo 
setwd("D:/TRABAJOFINAL/Resultados/Pacifico/UIG/")

#Cargar el mapa .asc
mapa_nicho <- raster("D:/TRABAJOFINAL/Resultados/Pacifico/UIG/modelo_nicho.asc")

# Ver información del raster
print(mapa_nicho)
crs(mapa_nicho)  #Ver la proyección

# Como el mapa tienen una proyección geográfica WGS84,"+proj=lonlat", la resolución está en grados y debe convertirse a KM2
# Cargar el raster del modelo de nicho (archivo .asc)
mapa_nicho <- raster("D:/TRABAJOFINAL/Resultados/Pacifico/UIG/modelo_nicho.asc")  # Cambia el nombre de tu archivo

# Definir un umbral para considerar "presencia"
umbral <- 0.4 

# Crear un raster binario (1 = presencia, 0 = ausencia)
mapa_binario <- mapa_nicho >= umbral

# Obtener la latitud media del mapa para la conversión de grados a km
lat_media <- mean(extent(mapa_nicho)[c(3,4)])  # Promedio de latitudes min y max

# Convertir resolución de grados a km (1 grado ≈ 111.32 km * cos(latitud))
res_x_km <- xres(mapa_nicho) * 111.32 * cos(lat_media * pi/180)
res_y_km <- yres(mapa_nicho) * 111.32 * cos(lat_media * pi/180)

# Área de cada píxel en km²
area_pixel_km2 <- res_x_km * res_y_km

# Contar los píxeles de presencia (donde el valor es 1)
num_pixeles_presencia <- sum(values(mapa_binario), na.rm = TRUE)

# Calcular el área total ocupada en km²
area_ocupada_km2 <- num_pixeles_presencia * area_pixel_km2

# Mostrar el resultado
print(paste("El área ocupada es de", round(area_ocupada_km2, 2), "km²"))



