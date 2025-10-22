# ================================
# FUNCIONES DE VISUALIZACIÓN
# ================================

# Mapa interactivo de propiedades
plot_map <- function(df) {
  leaflet(df) %>%
    addProviderTiles(providers$CartoDB.Positron) %>%
    addCircleMarkers(
      ~lon, ~lat,
      color = ~colorNumeric("YlOrRd", price)(price),
      radius = 4,
      opacity = 0.8,
      popup = ~paste0("<b>Precio:</b> ", round(price, 0), "<br>",
                      "<b>Área:</b> ", surface_total, " m²<br>",
                      "<b>Habitaciones:</b> ", rooms)
    )
}

# Distribución de precios
plot_price_distribution <- function(df) {
  ggplot(df, aes(x = price)) +
    geom_histogram(bins = 40, fill = "steelblue", color = "white") +
    scale_x_log10() +
    theme_minimal() +
    labs(title = "Distribución de precios", x = "Precio (log)", y = "Frecuencia")
}

# Importancia de variables (para RF o XGB)
plot_feature_importance <- function(model) {
  if ("importance" %in% names(model)) {
    imp <- as.data.frame(importance(model))
    imp$Feature <- rownames(imp)
    ggplot(imp, aes(x = reorder(Feature, IncNodePurity), y = IncNodePurity)) +
      geom_col(fill = "darkorange") +
      coord_flip() +
      theme_minimal() +
      labs(title = "Importancia de variables", x = "Variable", y = "IncNodePurity")
  } else {
    message("El modelo no tiene información de importancia de variables.")
  }
}
# Funciones para generar mapas, gráficos y tablas
