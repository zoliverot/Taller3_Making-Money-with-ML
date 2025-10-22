# ================================
# FUNCIONES DE MODELADO
# ================================

# Entrenar modelo de Random Forest
train_rf <- function(train_df, formula) {
  randomForest(formula, data = train_df, ntree = 500, mtry = 5, importance = TRUE)
}

# Entrenar modelo de XGBoost
train_xgb <- function(train_df, formula) {
  xgb_train <- model.matrix(formula, data = train_df)
  dtrain <- xgb.DMatrix(data = xgb_train, label = train_df$price)
  xgboost(data = dtrain, nrounds = 300, objective = "reg:squarederror", eta = 0.1)
}

# Evaluar modelo (RMSE)
evaluate_model <- function(model, test_df, formula) {
  preds <- predict(model, newdata = test_df)
  rmse <- sqrt(mean((test_df$price - preds)^2))
  return(rmse)
}

# Comparar modelos
compare_models <- function(models, test_df, formula) {
  results <- data.frame(Model = names(models), RMSE = NA)
  for (i in seq_along(models)) {
    results$RMSE[i] <- evaluate_model(models[[i]], test_df, formula)
  }
  arrange(results, RMSE)
}
# Funciones para entrenamiento y evaluación de modelos
