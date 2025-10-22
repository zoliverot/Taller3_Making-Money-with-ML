# ================================
# FUNCIONES DE MODELADO (7 MODELOS)
# ================================

# 1️ Regresión Lineal
train_lm <- function(train_df, formula) {
  lm(formula, data = train_df)
}

# 2️ Elastic Net
train_elnet <- function(train_df, formula) {
  ctrl <- trainControl(method = "cv", number = 5)
  train(formula, data = train_df, method = "glmnet",
        trControl = ctrl,
        tuneGrid = expand.grid(alpha = seq(0, 1, 0.1),
                               lambda = 10^seq(-3, 1, length = 20)))
}

# 3️ Árbol de Decisión (CART)
train_cart <- function(train_df, formula) {
  rpart(formula, data = train_df, method = "anova")
}

# 4️ Random Forest
train_rf <- function(train_df, formula) {
  randomForest(formula, data = train_df, ntree = 500, mtry = 5, importance = TRUE)
}

# 5️  XGBoost (Boosting)
train_xgb <- function(train_df, formula) {
  X <- model.matrix(formula, data = train_df)
  y <- train_df$price
  dtrain <- xgb.DMatrix(data = X, label = y)
  xgboost(data = dtrain, nrounds = 300, objective = "reg:squarederror", eta = 0.1)
}

# 6️  Red Neuronal
train_nn <- function(train_df, formula) {
  nnet(formula, data = train_df, size = 5, linout = TRUE, trace = FALSE, maxit = 1000)
}

# 7️ Super Learner
train_superlearner <- function(train_df, formula) {
  Y <- train_df$price
  X <- model.matrix(formula, data = train_df)[, -1]  # quitar intercepto
  SuperLearner(
    Y = Y,
    X = as.data.frame(X),
    SL.library = c("SL.lm", "SL.glmnet", "SL.randomForest", "SL.xgboost"),
    family = gaussian()
  )
}

# Función para evaluar (RMSE)
evaluate_model <- function(model, test_df, formula, type = "generic") {
  if (type == "xgb") {
    preds <- predict(model, newdata = model.matrix(formula, test_df))
  } else if (type == "sl") {
    preds <- predict(model, newdata = test_df)$pred
  } else {
    preds <- predict(model, newdata = test_df)
  }
  sqrt(mean((test_df$price - preds)^2))
}
