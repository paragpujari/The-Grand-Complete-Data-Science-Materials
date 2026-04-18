##### To perform the Simple Linear Regression on the Salary Dataset that contains the YearsExperience and Salary


###### Step 1: Import all the necessary libraries

import  numpy              as  np
import  pandas             as  pd
import  matplotlib.pyplot  as  plt
import  seaborn            as  sns


##### Step 2: Load the Dataset

df = pd.read_csv("Salary_Data.csv")

##### Step 3: Perform the Data Exploration

print("Total length of the dataset is:", len(df))

print(df.shape)

print(df.columns)

print(df.info())

print(df.describe())   ##### It explains about the statistical information about each column used in the dataset.

print(df.corr())       ##### It states that there is high correlation between the YearsExperience and Salary.

sns.heatmap(df.corr(), annot=True)


###### Step 4: Perform the Data Cleaning

print(df.isnull().sum())

print(df[df.duplicated()])


###### Step 5:  Divide the dataset into independent and dependent variables

#### independent variables

X = df[['YearsExperience']]

#### dependent variables

Y = df[['Salary']]


##### Step 6: Divide the independent and dependent variables into training and testing data


from  sklearn.model_selection  import  train_test_split

X_train, X_test, Y_train, Y_test = train_test_split(X,Y,test_size=0.2,random_state=42)


##### Step 7: Perform the Feature Scaling on the inputs

from sklearn.preprocessing  import  StandardScaler

#### create an object for Standard Scaler

sc = StandardScaler()

X_train_scaled = sc.fit_transform(X_train)

X_test_scaled  = sc.transform(X_test)

print(X_train_scaled)

print(X_test_scaled)


##### Step 8: Train the Linear Regression Model

from  sklearn.linear_model  import LinearRegression

#### create an object for linear regression

lin = LinearRegression()


#### using the object for linear regression, train the model

lin.fit(X_train_scaled, Y_train)


##### Step 9: Predict the Model

Y_pred = lin.predict(X_test_scaled)

print(Y_pred)


##### Step 10: Perform the Regression Metrics

from  sklearn.metrics  import mean_absolute_error, mean_squared_error, root_mean_squared_error, r2_score

mae = mean_absolute_error(Y_test, Y_pred)

print("Mean Absolute error of the model is:", mae)


mse = mean_squared_error(Y_test, Y_pred)

print("Mean Squared error of the model is:", mse)


rmse = root_mean_squared_error(Y_test, Y_pred)

print("Root Mean Squared error of the model is:", rmse)


r2 = r2_score(Y_test, Y_pred)

print("R2 Score of the model is:", r2)


############### Step 11: Apply the Ridge Regression #####################################333


from  sklearn.linear_model  import Ridge

print(X_train_scaled)

print(X_test_scaled)


ridge = Ridge(alpha=0.1)


#### using the object of Ridge, train the model

ridge.fit(X_train_scaled, Y_train)

#### perform the prediction on the model

Y_pred_ridge = ridge.predict(X_test_scaled)

print(Y_pred_ridge)

from  sklearn.metrics  import mean_absolute_error, mean_squared_error, root_mean_squared_error, r2_score

mae_ridge = mean_absolute_error(Y_test, Y_pred_ridge)

print("Mean Absolute Error for Ridge Regression is:", mae_ridge)


mse_ridge = mean_squared_error(Y_test, Y_pred_ridge)

print("Mean Squared Error for Ridge Regression is:", mse_ridge)



rmse_ridge = root_mean_squared_error(Y_test, Y_pred_ridge)

print("Root Mean Squared Error for Ridge Regression is:", rmse_ridge)


r2_ridge = r2_score(Y_test, Y_pred_ridge)

print("R2 Score for Ridge Regression is:", r2_ridge)





############### Step 12: Apply the Lasso Regression #####################################333


from  sklearn.linear_model  import Lasso

print(X_train_scaled)

print(X_test_scaled)


lasso = Lasso(alpha=1.0)


#### using the object of Ridge, train the model

lasso.fit(X_train_scaled, Y_train)

#### perform the prediction on the model

Y_pred_lasso = lasso.predict(X_test_scaled)

print(Y_pred_lasso)

from  sklearn.metrics  import mean_absolute_error, mean_squared_error, root_mean_squared_error, r2_score

mae_lasso = mean_absolute_error(Y_test, Y_pred_lasso)

print("Mean Absolute Error for Lssso Regression is:", mae_lasso)


mse_lasso = mean_squared_error(Y_test, Y_pred_lasso)

print("Mean Squared Error for Lasso Regression is:", mse_lasso)



rmse_lasso = root_mean_squared_error(Y_test, Y_pred_lasso)

print("Root Mean Squared Error for Lasso Regression is:", rmse_lasso)


r2_lasso = r2_score(Y_test, Y_pred_lasso)

print("R2 Score for Lasso Regression is:", r2_lasso)




############### Step 12: Apply the Elastic Net Regression #####################################333


from  sklearn.linear_model  import ElasticNet

print(X_train_scaled)

print(X_test_scaled)


elasticnet = ElasticNet(alpha=0.1, l1_ratio=0.5)


#### using the object of Ridge, train the model

elasticnet.fit(X_train_scaled, Y_train)

#### perform the prediction on the model

Y_pred_elasticnet = elasticnet.predict(X_test_scaled)

print(Y_pred_elasticnet)

from  sklearn.metrics  import mean_absolute_error, mean_squared_error, root_mean_squared_error, r2_score

mae_elasticnet = mean_absolute_error(Y_test, Y_pred_elasticnet)

print("Mean Absolute Error for Elastic Net Regression is:", mae_elasticnet)


mse_elasticnet = mean_squared_error(Y_test, Y_pred_elasticnet)

print("Mean Squared Error for Elastic Net Regression is:", mse_elasticnet)



rmse_elasticnet = root_mean_squared_error(Y_test, Y_pred_elasticnet)

print("Root Mean Squared Error for Elastic Net Regression is:", rmse_elasticnet)


r2_elasticnet = r2_score(Y_test, Y_pred_elasticnet)

print("R2 Score for Elastic Net Regression is:", r2_elasticnet)