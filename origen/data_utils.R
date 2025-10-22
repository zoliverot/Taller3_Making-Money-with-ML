# ================================
# FUNCIONES DE LIMPIEZA Y DATOS
# ================================

# Limpieza básica: eliminar NA, limpiar texto y crear variables estándar
clean_data <- function(df) {
  df %>%
    filter(!is.na(price), !is.na(surface_total)) %>%
    mutate(
      price_m2 = price / surface_total,
      rooms = ifelse(is.na(rooms), median(rooms, na.rm = TRUE), rooms)
    )
}

# Leer y combinar datos crudos
load_and_merge_data <- function() {
  files <- list.files(path_data_raw, pattern = "*.csv", full.names = TRUE)
  data_list <- lapply(files, read_csv)
  df <- bind_rows(data_list)
  clean_data(df)
}
# Funciones para limpieza y unión de datos
