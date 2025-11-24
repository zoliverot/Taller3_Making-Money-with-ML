# Problem Set 3 — Making Money with ML?

**Equipo_08**  
Maestría en Economía Aplicada — Universidad de los Andes  
Curso: *Big Data y Machine Learning para Economía Aplicada*  
Año: 2025  

---

## Descripción general

Este repositorio contiene el desarrollo del **Problem Set 3 — Making Money with ML?**, cuyo objetivo es **predecir los precios de vivienda en Chapinero (Bogotá)** utilizando modelos de *machine learning*.

El trabajo cubre todo el ciclo analítico:
- Limpieza y preparación de datos (Properati + datos externos),
- Creación de variables (features),
- Entrenamiento y validación de 7 modelos,
- Evaluación espacial,
- Comparación de resultados y entrega final tipo *Kaggle*.

---

## Estructura del repositorio


| Carpeta / Archivo       | Descripción                                   |
|-------------------------|-----------------------------------------------|
| `data/`                 | Datos crudos, procesados y externos          |
| `notebooks/`            | Notebooks `.Rmd` (01 a 07)                   |
| `origen/`               | Funciones R (config, modelado)               |
| `outputs/`              | Resultados (gráficos, tablas, predicciones) |
| `reports/`              | Informe y presentación final                 |
| `README.md`             | Este archivo                                 |


## Reproducibilidad
1. Abre el proyecto en RStudio (`ps3-ml-housing-equipo_08.Rproj`).
2. Instala los paquetes requeridos:
```r
install.packages(readLines('requirements_R.txt'))
```
3. Ejecuta los notebooks en orden (01 → 07).

| Notebook                     | Descripción                              |
|-------------------------------|------------------------------------------|
| `01_data_cleaning.Rmd`        | Limpia los datos crudos                  |
| `02_superlearner.Rmd`         | Crea Superlearner                        |
| `03_Redes_neuronales.Rmd`     | Creación de Redes Neuronales             |
| `04_Regresión Lineal.Rmd`     | Creación de Regresiones Lineales         |
| `05_ElasticNet.Rmd`           | Creación de ElasticNet                   |
| `06_Boosting.Rmd`             | Crear Modelos Boosting                   |
| `07_RF y CART.Rmd`            | Modelos Random Forest y CART             |

4. Salidas esperadas
- Gráficos y mapas (outputs/figures/)
- Predicciones Kaggle (outputs/kaggle_submissions/)
- Informe final (reports/ps3_report.pdf)

## Equipo de trabajo

| Integrante | Código |
|-------------|------|
| **Vivian Cabanzo Fernández** | 202513800 | 
| **Laura Daniela Diaz Torres** | 202425507 |
| **Cristian Felipe Muñoz Guerrero** | | 
| **Zeneth Olivero Tapia** | 202512665 |

## Resultados principales
- Mejor modelo: RF ESPACIAL

## Referencias
- Rosen (1974). *Hedonic Prices and Implicit Markets.*  
- Zillow Offers (2021). *The $500MM Debacle.*  
- Properati Data (DANE, 2024)
- OpenStreetMap (OSM) — capas espaciales

---
**Repositorio:** https://github.com/zoliverot/Taller3_Making-Money-with-ML
