# ================================
# CONFIGURACIÓN GLOBAL DEL PROYECTO
# ================================

# Semilla para reproducibilidad
set.seed(2025)

# Rutas principales
path_data_raw <- "data/raw/"
path_data_processed <- "data/processed/"
path_outputs <- "outputs/"
path_figures <- file.path(path_outputs, "figures/")
path_tables <- file.path(path_outputs, "tables/")
path_models <- file.path(path_outputs, "models/")

# Librerías base
required_packages <- c(
  "tidyverse", "sf", "caret", "rpart", "ranger",
  "randomForest", "xgboost", "nnet", "glmnet", 
  "tmap", "leaflet", "spdep"
)

# Cargar librerías automáticamente
invisible(lapply(required_packages, function(pkg) {
  if (!require(pkg, character.only = TRUE)) install.packages(pkg)
  library(pkg, character.only = TRUE)
}))
# Parámetros globales del proyecto
