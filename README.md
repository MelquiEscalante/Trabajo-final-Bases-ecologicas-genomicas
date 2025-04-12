# Trabajo-final-Bases-ecologicas-genomicas
# Cómo el modelado de nicho ecológico histórico puede ayudar a explicar la variación genética en las poblaciones del loro cabeza amarilla (*Amazona oratrix*)
Se analiza la paleodistribución desde el Último Inter glacial al Presente en las poblaciones mexicanas de Amazona oratrix, empleando datos de avistamiento y capas bioclimáticas de worldclim en el periódo de 1970 al 2000.

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
Para el modelado de nicho histórico se descargaron las 19 variables ambientales de Wolrdclim con temporalidades de 1970 al 2000 a través de R, que representan las variables ambientales al PRESENTE, posteriormente estas fueron recortadas.

```r
# Descarga de las 19 variables ambientales de Worldclim de 1970 - 2000 a resolución 2.5 m.
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

# Recortar estas 19 variables ambientales usando un shapefile de México.
```

# Resultados


# Conclusión 
- En las poblaciones del Pacífico, la evolución del nicho parece ser estable, sin expansiones, ni contracciones considerables desde el UIG. En el Golfo de México, las poblaciones parecen haber experimentado una expansion considerable ocurrida en el UMG. Comparando ambos nichos, el Pacífico parece mantener, en las proyecciones, un nicho restringido siempre a la costa, siendo este muy estrecho, en comparación con el Golfo de México, donde las poblaciones parecen ocupar gran parte de la planicie costera.
- Considerando las extenciones en Km2 estimadas para las poblaciones del Pacífico desde el Último Inter Glacial al Presente, podemos deducir que probablemente el tamaño del nicho ecológico ocupado en este linaje ha mantenido tamaños poblacionales pequeños, por lo que los efectos de la deriva pudieron ser quizá mas fuertes, manteniendo bajos niveles de variación genética mitocondrial (Crow & Kimura, 1970; Hedrick, 2011), que es lo que se ha recuperado para este linaje en el trabajo de Escalante-Vargas & Escalante-Pliego (En prensa). Respecto a las poblaciones del Golfo de México, el haplogrupo en forma de estrella, encontrado en el trabajo previamente citado de Escalante-Vargas, indica una expansion poblacional en timepos recientes (Bandelt et al. 1995; Excoffier et al. 2009), por lo que, dicho patrón recuperado podría ser el resultado del proceso de expansión de hace ~20 a ~11 mil años.
- Ambas distribuciones han sido moldeadas principalmente por temperaturas y precipitaciones. A pesar de lo anterior, cuando se realiza el MNE de una, en la región contraparte no se encuentran las mismas condiciones para que la primera pueda estar presente. Por lo que el orden de contribución de las variables sí influye en la distribución de las poblaciones.

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









