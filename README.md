# Trabajo-final-Bases-ecológicas-genómicas
# Cómo el modelado de nicho ecológico histórico puede ayudar a explicar la variación genética en las poblaciones del loro cabeza amarilla (*Amazona oratrix*)
Se analiza la paleodistribución desde el Último Inter glacial al Presente en las poblaciones mexicanas de *Amazona oratrix*, empleando datos de avistamiento y capas bioclimáticas de worldclim en el periódo de 1970 al 2000.

# **Introducción** 
El loro cabeza amarilla (*Amazona oratrix*) es una especie de psitácido que se distribuye en un conjunto de poblaciones alopátricas desde Méxio a Honduras. A lo largo de su distribución se reconocen seis subespecies, cada una de las cuales está asentada en diferentes tipos de vegetación (Howell & Webb, 1995; Fig. 1). 

<img src="https://github.com/user-attachments/assets/fe4fb6c5-4429-4b0d-99e7-074b3cf8b09e" alt="Demo" width="800"/>

**Fig. 1** Mapa de distribucion de *Amazona oratrix* y de sus subespecies.

En la actualidad los estudios de modelado de nicho ecológico en la especie solo se restrigen a unos pocos en los que se evalúan su distribución potencial para algunas regiones muy particulares como en la península de Yucatán (Plasencia-Vázquez et al. 2014), y por otro lado existen otros estudios en los que se evalúa la contracción de sus poblaciones por efecto de la deforestación y la disponibilidad de nicho existente en la actualidad (Monterrubio-Rico et al. 2007). Particularmente los estudios sobre paleodistribución en esta especie son escazos, por lo que considerando ese vacío en la información y los resultados previos de un estudio sobre estructura genética mitocondrial en las poblaciones Mexicanas del loro cabeza amarilla en el que se encontró una divergencia profunda entre las poblaciones del Pacífico y las del Golfo de México, delimitada por al menos 26 sustituciones (Escalante-Vargas & Escalante-Pliego, en prensa; Fig. 2), y considerando que estos dos conjuntos de poblaciones estan asentadas sobre provincias bióticas distintas, en la que, sobre el pacífico predomina la selva seca caducifolia y subcaducifolia, mientras que en el Golfo de México las selvas tropicales húmedas (Escalante-Pliego et al. 1993; Fig. 3). 

<img src="https://github.com/user-attachments/assets/79a00d71-7a6c-428f-bded-167113b480d4" alt="Demo" width="700"/>

**Fig. 2** Haplogrupos encontrados al analizar las poblaciones de *Amazona oratrix* a través de los genes mitocondriales COI y ND2. En verde el haplogrupo que incluye a las poblaciones del Pacífico, y en amarilla el haplogrupo en el que se incluyen las poblaciones de la vertiente del Atlántico (Escalante-Vargas & Escalante-Pliego, en prensa).

<img src="https://github.com/user-attachments/assets/23792b5d-7b2c-4d95-8b5e-3da7f66755c6" alt="Demo" width="700"/>

**Fig. 3** Tipos de vegetación encontrados sobre la distribucion de las poblaciones mexicanas de *A. oratrix*. A) Selvas secas caducifolias encontradas sobre la vertiente del Pacífico, siendo esta la vegetación dominante en esta provincia biótica. B) Selvas tropicales húmedas sobre la vertiente del Golfo de México. 

# **Objetivos**

Reconstruir la distribución histórica a través del modelado de nicho ecológico para determinar si estos patrones de distribución pueden explicar la variación genética en los linajes mexicanos de *A. oratrix*.

  Objetivos particulares
  1. Recuperar los patrones de distribución en las poblaciones del Pacífico y Golfo de México de A. oratrix en el presente, Holoceno medio, Último Máximo Glacial y Último Inter Glacial. 
  2. Inferir como estos cambios ambientales influyeron en la composición genética actual de cada linaje.
  3. Conocer las variables ambientales que más influyen en la distribución de ambos linajes.

# **Metodología**
  ### Descarga de capas de las variables ambientales de Worldclim
Para el modelado de nicho histórico se descargaron las 19 variables ambientales de Wolrdclim con temporalidades de 1970 al 2000 a través de R, que representan las variables ambientales al PRESENTE, posteriormente estas fueron recortadas.
De igual forma se descargaron las 19 variables ambientales para el Holoceno medio (hace 6,000 años), Último Máximo Glacial (hace 21,000 años) a 2.5 minutos de resolución y del Último Inter Glacial (hace 120,0000 a 140,000 años), con una resolución de 30 segundos. Todas estas variables ambientales fueron descargadas de la página de Worldclim (https://www.worldclim.org/data/bioclim.html), y posteriormente recortadas al tamaño de México usando un archivo shapefile.

```r
# ----- Script para descargar variables bioclimáticas de Worldclim, en este caso es para el Holoceno medio con resolución de 2.5 minutos -----------

install.packages(c("geodata", "archive"))
library(geodata)
library(archive)

#Configurar el directorio de trabajo
setwd("D:/TRABAJOFINAL/CapasBioclimáticas/HOLOCENOMED")

# Definir directorio de descarga
dir.create("D:/TRABAJOFINAL/CapasBioclimáticas/HOLOCENOMED", showWarnings = FALSE)

# Descargar datos del Holoceno de WorldClim v1.4 con resolución de 2.5 minutos  
download.file("https://geodata.ucdavis.edu/climate/cmip5/mid/memidbi_2-5m.zip",    # agrega la direccion URL del periódo del cuál quieras descargar las capas de Worldclim
              destfile = "bio_Holoceno.zip", mode = "wb")

# Extraer archivos
archive::archive_extract("bio_Holoceno.zip", dir = "Holoceno-medio")

# Listar archivos extraídos
list.files("Holoceno-medio")
```

  ### Descarga de Avistamientos de GBIF
Los registros de avistamientos de esta especie en México, fueron descargados de la página de GBIF (https://www.gbif.org/es/occurrence/search?taxon_key=2479646) directamente, una vez descargados, estos fueron limpiados tanto en excel cmo QGIS para el periódo de 1970 al 2000, y posteriormente estos registros fueron separados en Pacífico y Golfo de México, agrupándose en dos grandes grupos siguiendo la estructura genética encontrada en el trabajo de Escalante-Vargas & Escalante-Pliego (En prensa; Fig. 2).

  ### Análisis de reconstrucción del modelado de nicho ecológico al pasado
Todos los análisis de hicieron en R por separado, por un lado se realizaron reconstrucciones de las más probables áreas de idoneidad al último Inter Glacial, Último Máximo Glacial, Holoceno Medio y Presente para las poblaciones del Golfo de México y se estimó, para el presente cuales eran las ocho variables que más influyen en el nicho ecológico de estas poblaciones. Estos mismos análisis fueron realizados para las poblaciones del Pacífico. 
De igual forma, para cada uno de los mapas obtenidos, en estas cuatro temporalidades, se estimó la cobertura en Km2 de la ocupación del nicho tanto para el Golfo de México como para el Pacífico considerando los pixeles ocupados en las proyecciones de idoneidad de cada mapa, en este sentido, se consideró que cada píxel tiene una superficie aproximada de 4.625 km × 4.625 km ≈ 21.4 km² en el ecuador, para el cálculo del área ocupada se consideró un humbral de presencia de 0.4 a 1 y a partir de esta consideración y del mapa generado en formato .asc se realizó el cálculo de la siguiente forma:

```r
# Cargar el mapa de idoneidad .asc generado +
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
```
Lo anterior se realizó para conocer como cambiaba la extensión del nicho a lo largo del tiempo y ver si a traves de estos cambios se podría inferir si estos tuvieron efectos que expliquen los patrones de estructura al interior de cada linaje (Pacífico y Golfo de México) ilustrados en la Gif 2.

Todos los análisis previamente descritos fueron desarrollados en R, y algunos mapas editados en QGIS. El scrip completo empleado en R está anexo en este repositorio (https://github.com/MelquiEscalante/Trabajo-final-Bases-ecologicas-genomicas/blob/main/Scrip%20trabajo%20final.R) y puede ser reproducido cambiando las rutas particulares de tu equipo de computo, igual dependerá de la capacidad de tu máquina, ya que la mía tiene poca, solo realicé una réplica, aunque los análisi fueron también corridos independiente en el software MaxEnt para comprobar los resultados obtenidos en R.

# Resultados
A partir de 224 registros de avistamientos para el Golfo de México, y 229 para las poblaciones del Pacífico, se encontró que las tres variables ambientales que más contribuyen al modelado de nicho ecológico en el presente para las poblaciones del Golfo de México fueron la Bio14 (precipitación del mes más seco), Bio2 (rango medio diurno de temperatura) y Bio6 (temperatura mínima del mes más frío) las cuales aportan un poco más del 62% (Fig. 4) al modelado de nicho. Por su parte, para las poblaciones del Pacífico, las tres variables más importantes fueron la Bio 11 (Temperatura media del trimestre más frío), Bio4 (Estacionalidad de la temperatura) y la Bio15 (Estacionalidad de la precipitación), las cuales aportanron al modelado más del 66% (Fig. 4). 

<img src="https://github.com/user-attachments/assets/a452c722-b979-4442-88ea-7fecc55b678b" alt="Demo" width="600"/>

**Fig. 4** Variables ambientales que más contribuyen al modelado del nicho ecológico en el presente para las A) Poblaciones del Golfo de México y B) Para las poblaciones del Pacífico.

Con respecto a los resultados obtenidos sobre las estimaciones de paleodistribución en las poblaciones del Golfo de México, se recuperó que para el Último Inter Glacial, hace ~140,000 a ~120,0000 años, el nicho ecológico histórico para estas poblaciones en esta área geográfica ocupaba una probable extención de 37,197.87 km² (Fig. 5A), mientras que para el Último Máximo Glacial, la extension pudo haber aumentado a 68,154.42 km² (Fig. 5B), lo que representa un aumento del ~83%, sin embargo hace ~6,000 años, en el Holoceno medio, esta extencion probablemente pudo haberse reducido en un 37%, por lo que la cobertura con condiciones ambientales favorables para la presencia de estas poblaciones pudo haberse contraido a ~42,908.12 km² (Fig.5C). Para el presente, esta última estimación posiblemente se redujo hasta quedar en 39,133.8 km² (reduccion del 8.8 %). 

![mapa_golfo](https://github.com/user-attachments/assets/e63676e8-f522-4813-afa1-f672704c1551)

**Fig. 5** Modelado de nicho ecológico histórico para las poblaciones de loros cabeza amarilla (*A. oratrix*) del Golfo de México. A) Último Inter Glacial, B) Último Máximo Glacial, C) Holoceno Medio y D) Presente.

Con relacion a las poblaciones del Pacífico, la reconstruccion al Último Inter Glacial mostró que es probable que este linaje ocupara una reducida área restringida a la costa de esta vertiente, la cual pudo haber cubierto un área de ~18,110.26 km² (Fig.6A), sin embargo, para el Último Máximo Glacial, este nicho ecológico pudo haberse extendido a 23,918.53 km² aproximadamente, lo que representa un incremente del ~32% (Fig. 6B). Para el Holoceno medio (hace 6,000 años), la region de idoneidad para la distribución de estas poblaciones pudo haberse incrementado ligeramente en un 10.5% (a 26,438.34 km²; Fig. 6C), mientras que para el presente, considernado los resultados, posiblemente pudo haber un ligero aumento del 8.5%, lo que representa una cobertura de condiciones favorables para la presencia de la especie de 28,695.71 km² (Fig.6D).

![mapa_pacífico](https://github.com/user-attachments/assets/c6a78580-d088-4b23-a67c-33684f4807a6)

**Fig. 6** Modelado de nicho ecológico histórico para las poblaciones de loros cabeza amarilla (*A. oratrix*) del Pacífico. A) Último Inter Glacial, B) Último Máximo Glacial, C) Holoceno Medio y D) Presente.

# Conclusión 
- En las poblaciones del Pacífico, la evolución del nicho parece incrementarse ligeramente desde el UIG, pero siempre ocupando un área menor que su poblacion vecina del Golfo. Estos ligeros incrementos podrían deberse a que los cambios ambientales ocurridos en el pasado, como los de temperatura y precipitación, probablemente propiciaron que nuevas áreas fueran idóneas para colonizar nuevos nichos disponibles para estas poblaciones de loros cabeza amarilla. Sin embargo, estas han ocupado, desde el UIG, un área de idoneidad restringida a una franja estrecha a las tierras bajas de la vertiente del mismo nombre.
- En el Golfo de México, las poblaciones parecen haber experimentado una expansion considerable ocurrida en el UMG. En todos los escenarios, este linaje ocupa una region de áreas idoneas de distribucion superior a la del Pacífico, posiblemente debido a que estas poblaciones ocupan gran parte de las tierras bajas de la llanura costera del Golfo, la cual es mucho más extensa que las tierras bajas de la vertiente del Pacífico. La expansion ocurrida durante el UMG en el Golfo, la cual casi triplica la expansión experimentada en el Pacífico para la misma temporalidad, se debe posiblemente a que por un lado, el desenso del mar dejó al descubierto porciones de tierras bajas que antes estaban sumergidas y la que ahora proporcionaron nuevos espacios disponibles para colonizar por este linaje de loros, loq ue les permitió ampliar sus nichos ecológicos. Por otro lado, es probable que los cambios de tempratura y precipitación del UMG, hayan beneficiado a que cierta regiones más al norte y al Sur de México fueron idóneas para aumentar la distribucion geográfica de estas poblaciones.
- Considerando las extenciones en km² estimadas para las poblaciones del Pacífico desde el Último Inter Glacial al Presente, podemos deducir que probablemente el reducido tamaño del nicho ecológico ocupado en este linaje (en comparación con el Golfo de México) ha mantenido tamaños poblacionales pequeños, por lo que podemos deducir que posiblemente en estas poblaciones los efectos de la deriva genética pudieron ser quizá mas fuertes, manteniendo bajos niveles de variación genética mitocondrial (Crow & Kimura, 1970; Hedrick, 2011) lo queha resultado en un haplogrupo con muy pocos haplotipos (Fig. 2). Respecto al Golfo de México, el haplogrupo en forma de estrella encontrado para estas poblaciones (Fig. 2), indica una expansion poblacional en tiempos relativamente recientes (Bandelt et al. 1995; Excoffier et al. 2009), por lo que, dicho patrón recuperado podría ser el resultado del proceso de expansión de hace ~20 a ~11 mil años ocurrido durante el UMG.
- A través del análisis de las 19 variables ambientales para el modelado de nicho ecológico (MNE) en ambos linajes en el presente, podemos concluir que, ambos han sido moldeadas principalmente por temperaturas y precipitaciones. A pesar de lo anterior, cuando se realiza el MNE de una (Por ejemplo para el Pacífico), en la región contraparte (Golfo de México) no se encuentran las mismas condiciones ambientales para que la primera pueda estar presente. Por lo que el orden de contribución de las variables sí influye en la distribución de las poblaciones.
- De forma general se concluye tentativamente que, estos linajes presentan una evolución de nicho histórica distinta, las cuales se vieron modificadas por los cambios ambientales al menos desde el UIG al presente. Sin embargo estas conclusiones son aproximadas ya que es necesario considerar que estas distribuciones históricas pudieron verse tambien modificadas por las interacciones con otros organismos, la presencia de barreras geográficas que pudieron tambien limitado la distribucion de la especie. En el presente ocurre lo mismo, sin embargo, aqui hay que considerar las presiones adicionales de captura para el tráfico ilegal y las altas tasas de deforestación que reducen aún más las poblaciones remanentes de loros cabeza amarilla en ambas vertientes.

Los resultados obtenidos, así como las carpetas de las variables bioclimáticas empleadas y datos de avistamientos pueden ser obtenidos a través de la siguiente liga en GoogleDrive (https://drive.google.com/drive/folders/13u68j6d2qWzaFyhPyfKJrc0PxX93cqcC?usp=drive_link).

# Bibliografía
- Bandelt, H.J., Forster, P., Sykes, B. C. & Richards, M. B. (1995). Mitochondrial portraits of human populations using median networks. *Genetics*, 141 (2), 743–753.
- Crow, J.F. & Kimura, M. (1970). An introduction to population genetics. Harper & Row.
- Escalante-Pliego, P., Navarro-Sigüenza, A.G. & Peterson, A.T. (1993). A geographic, Ecological and historical analysis of land bird diversity in México. En Ramamoorthy, T.P., Bye, R. & Lot, L. (Eds). Biological diversity of México: origins and distribution. (pp. 281−307). Oxford Univ. Press.
- Escalante-Vargas, M. & Escalante-Pliego, P. (En prensa). Phylogeography of the endangered Yellow-headed parrot (*Amazona oratrix*). *Avian Research*.
- Excoffier, L., Foll, M. & Petit, R. (2009). Genetic consequences of range expansions. *Annu. Rev. Ecol. Evol. Syst.* 40 (1): 481-501.
- Hedrick, P.W. (2011). Genetics of Populations. Jones and Bartlett Publishers.
- Howell, S.N.G. & Webb, S. (1995). A guide to the birds of Mexico and Northern Central America. Oxford University Press.
- Monterrubio-Rico, T. C., Villaseñor-Gómez, L. E., Marín-Togo, M. C., López-Córdova, E. A., Fabian-Turja, B. & Sorani-Dalbón, V. (2007). Distribución histórica y actual del loro cabeza amarilla (Amazona oratrix) en la costa central del pacífico mexicano, ventajas y limitaciones en el uso de GARP en especies bajo fuerte presión de tráfico. *Ornitología Neotropical*, 18 (2), 263–276.
- Plasencia-Vázquez, A.H., Escalona-Segura, G. & Esparza-Olguín, L.G. (2014). Modelación de la distribución geográfica potencial de dos especies de psitácidos neotropicales utilizando variables climáticas y topográficas. *Acta Zoológica Mexicana, 30 (3), 471-490.*









