# ==========================================================
# FUNCIONES DE MODELADO - PS3: Making Money with ML?
# Equipo_08 | Big Data y Machine Learning - Uniandes
# ==========================================================

# Librerías necesarias
if (!require("caret")) install.packages("caret")
if (!require("glmnet")) install.packages("glmnet")
if (!require("rpart")) install.packages("rpart")
if (!require("randomForest")) install.packages("randomForest")
if (!require("xgboost")) install.packages("xgboost")
if (!require("nnet")) install.packages("nnet")
if (!require("SuperLearner")) install.packages("SuperLearner")

library(caret)
library(glmnet)
library(rpart)
library(randomForest)
library(xgboost)
library(nnet)
library(SuperLearner)

# ==========================================================
# 1️ REGRESIÓN LINEAL
# ==========================================================
train_lm <- function(train_df, formula) {
  lm(formula, data = train_df)
}

# ==========================================================
# 2️ ELASTIC NET (Regularización)
# ==========================================================
train_elnet <- function(train_df, formula) {
  ctrl <- trainControl(method = "cv", number = 5)
  train(
    formula,
    data = train_df,
    method = "glmnet",
    trControl = ctrl,
    tuneGrid = expand.grid(
      alpha = seq(0, 1, 0.1),
      lambda = 10^seq(-3, 1, length = 20)
    )
  )
}

# ==========================================================
# 3️ ÁRBOL DE DECISIÓN (CART)
# ==========================================================
train_cart <- function(train_df, formula) {
  rpart(formula, data = train_df, method = "anova", control = rpart.control(cp = 0.01))
}

# ==========================================================
# 4️ RANDOM FOREST
# ==========================================================
train_rf <- function(train_df, formula) {
  randomForest(formula, data = train_df, ntree = 500, mtry = 5, importance = TRUE)
}

# ==========================================================
# 5️ BOOSTING (XGBoost)
# ==========================================================
train_xgb <- function(train_df, formula) {
  X <- model.matrix(formula, data = train_df)
  y <- train_df$price
  dtrain <- xgb.DMatrix(data = X, label = y)
  
  xgboost(
    data = dtrain,
    nrounds = 300,
    objective = "reg:squarederror",
    eta = 0.1,
    max_depth = 6,
    verbose = 0
  )
}

# ==========================================================
# 6️ RED NEURONAL (nnet)
# ==========================================================
train_nn <- function(train_df, formula) {
  nnet(formula, data = train_df, size = 5, linout = TRUE, trace = FALSE, maxit = 1000)
}

# ==========================================================
# 7️ SUPER LEARNER (Ensamblado de modelos)
# ==========================================================
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

# ==========================================================
# FUNCIÓN DE EVALUACIÓN (RMSE)
# ==========================================================
evaluate_model <- function(model, test_df, formula, type = "generic") {
  if (type == "xgb") {
    preds <- predict(model, newdata = model.matrix(formula, test_df))
  } else if (type == "sl") {
    X_test <- model.matrix(formula, data = test_df)[, -1]
    preds <- predict(model, newdata = as.data.frame(X_test))$pred
  } else {
    preds <- predict(model, newdata = test_df)
  }
  
  rmse <- sqrt(mean((test_df$price - preds)^2))
  return(rmse)
}

# ==========================================================
# COMPARAR VARIOS MODELOS
# ==========================================================
compare_models <- function(models, test_df, formula) {
  results <- data.frame(Model = names(models), RMSE = NA)
  
  for (i in seq_along(models)) {
    model_name <- names(models)[i]
    model_type <- ifelse(grepl("xgb", model_name, ignore.case = TRUE), "xgb",
                         ifelse(grepl("sl", model_name, ignore.case = TRUE), "sl", "generic"))
    
    results$RMSE[i] <- evaluate_model(models[[i]], test_df, formula, type = model_type)
  }
  
  results <- arrange(results, RMSE)
  print(results)
  return(results)
}

