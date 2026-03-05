import numpy as np
import pandas as pd
from sklearn.datasets import fetch_california_housing
from sklearn.model_selection import train_test_split, KFold
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import StandardScaler
from sklearn.linear_model import LinearRegression, Ridge, Lasso
from sklearn.metrics import mean_squared_error
from sklearn.model_selection import GridSearchCV

X, y = fetch_california_housing(return_X_y=True, as_frame=True)
X_train, X_test, y_train, y_test = train_test_split(
X, y, test_size=0.25, random_state=0
)


# Régression linéaire ordinaire
ols = Pipeline([
("scaler", StandardScaler()),
("model", LinearRegression())
])
ols.fit(X_train, y_train)
pred = ols.predict(X_test)
print("============ Performance OLS ============")
rmse_ols = np.sqrt(mean_squared_error(y_test, pred))
print("RMSE OLS:", rmse_ols)
print("")


# Ridge
ridge = Pipeline([
("scaler", StandardScaler()),
("model", Ridge())
])
alphas = np.logspace(-4, 4, 60)
cv = KFold(n_splits=10, shuffle=True, random_state=0)
grid_ridge = GridSearchCV(
                estimator=ridge,
                param_grid={"model__alpha": alphas},
                scoring="neg_root_mean_squared_error",
                cv=cv,
                n_jobs=-1
                )
grid_ridge.fit(X_train, y_train)
print("============ Paramètres Ridge ============")
print(grid_ridge.best_params_, -grid_ridge.best_score_)

print("============ Performance Ridge ============")
best_ridge = grid_ridge.best_estimator_
pred = best_ridge.predict(X_test)
rmse_ridge = np.sqrt(mean_squared_error(y_test, pred))
print("RMSE Ridge:", rmse_ridge)
print("")

# Lasso
lasso = Pipeline([
("scaler", StandardScaler()),
("model", Lasso(max_iter=20000))
])
grid_lasso = GridSearchCV(
estimator=lasso,
param_grid={"model__alpha": alphas},
scoring="neg_root_mean_squared_error",
cv=cv,
n_jobs=-1
)
grid_lasso.fit(X_train, y_train)
print("============ Paramètres Lasso ============")
print(grid_lasso.best_params_, -grid_lasso.best_score_)

best_lasso = grid_lasso.best_estimator_
pred = best_lasso.predict(X_test)
rmse_lasso = np.sqrt(mean_squared_error(y_test, pred))
print("============ Performance Lasso ============")
print("RMSE Lasso:", rmse_lasso)