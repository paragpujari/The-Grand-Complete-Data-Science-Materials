#### Perform the Regularization techniques on the Housing Price dataset

###### Step 1:  Import  all the necessary libraries

import  numpy              as  np
import  pandas             as  pd
import  matplotlib.pyplot  as  plt
import  seaborn            as  sns

from    sklearn.model_selection  import  train_test_split
from    sklearn.preprocessing    import  StandardScaler, PolynomialFeatures
from    sklearn.linear_model     import  LinearRegression, Ridge, Lasso, ElasticNet

####### Step 2: Load the Dataset

df = pd.read_csv("Housing.csv")


###### Step 3: Perform the Data Exploration

print(df.head())

print(df.tail())

print(df.shape)

print(df.columns)

print("Total records used in the dataset is:", len(df))

print(df.info())

print(df.describe(include=[np.number]))


##### Step 4: Perform the Data Cleaning

print(df.isnull().sum())

print(df[df.duplicated()])

###### Step 5: Perform the Feature Engineering

df['mainroad']        =     df['mainroad'].map({"yes":1,"no":0})
df['guestroom']       =     df['guestroom'].map({"yes":1,"no":0}) 
df['basement']        =     df['basement'].map({"yes":1,"no":0})  
df['hotwaterheating'] =     df['hotwaterheating'].map({"yes":1,"no":0})
df['airconditioning'] =     df['airconditioning'].map({"yes":1,"no":0})
df['prefarea']        =     df['prefarea'].map({"yes":1,"no":0})

from   sklearn.preprocessing  import  LabelEncoder

#### create an object for Label Encoder
label = LabelEncoder()

df['furnishingstatus'] = label.fit_transform(df['furnishingstatus'])

print(df.head())


###### Step 6:  Divide the dataset into independent and dependent features

X = df.drop(columns='price')

Y = df['price']

print(X)

print(Y)


##### Step 7: Divide the independent and dependent features into training and testing data

from  sklearn.model_selection  import  train_test_split

X_train, X_test, Y_train, Y_test = train_test_split(X,Y,test_size=0.2,random_state=42)


##### Step 8: Perform the Feature Scaling on the inputs

from  sklearn.preprocessing  import  StandardScaler

sc = StandardScaler()

X_train_scaled = sc.fit_transform(X_train)

X_test_scaled  = sc.transform(X_test)


print(X_train_scaled)

print(X_test_scaled)


###### Step 9: Train the Linear Regression Model

from  sklearn.linear_model  import LinearRegression, Ridge, Lasso, ElasticNet

lin = LinearRegression()

lin.fit(X_train_scaled, Y_train)

ridge = Ridge(alpha=1.0)

ridge.fit(X_train_scaled, Y_train)


lasso = Lasso(alpha=0.1)

lasso.fit(X_train_scaled, Y_train)


elasticnet = ElasticNet(alpha=1.0, l1_ratio=0.5)

elasticnet.fit(X_train_scaled, Y_train)


##### Step 10: Predict the model

Y_pred = lin.predict(X_test_scaled)

print(Y_pred)


Y_pred_ridge = ridge.predict(X_test_scaled)

print(Y_pred_ridge)

Y_pred_lasso = lasso.predict(X_test_scaled)

print(Y_pred_lasso)


Y_pred_elasticnet = elasticnet.predict(X_test_scaled)

print(Y_pred_elasticnet)


##### Step 11: Perform the evaluation metrics

from  sklearn.metrics  import  mean_absolute_error, mean_squared_error, root_mean_squared_error, r2_score

mae = mean_absolute_error(Y_test, Y_pred)
print("Mean Absolute error of the model is:", mae)

mse = mean_squared_error(Y_test, Y_pred)
print("Mean Squared error of the model is:", mse)

rmse = root_mean_squared_error(Y_test, Y_pred)
print("Root Mean Squared error of the model is:", rmse)

r2 = r2_score(Y_test, Y_pred)
print("R2 Score of the model is:", r2)




maeridge = mean_absolute_error(Y_test, Y_pred_ridge)
print("Ridge Mean Absolute error of the model is:", maeridge)

mseridge = mean_squared_error(Y_test, Y_pred_ridge)
print("Ridge Mean Squared error of the model is:", mse)

rmseridge = root_mean_squared_error(Y_test, Y_pred_ridge)
print("Ridge Root Mean Squared error of the model is:", rmseridge)

r2ridge = r2_score(Y_test, Y_pred_ridge)
print("Ridge R2 Score of the model is:", r2ridge)




maelasso = mean_absolute_error(Y_test, Y_pred_lasso)
print("Lasso Mean Absolute error of the model is:", maelasso)

mselasso = mean_squared_error(Y_test, Y_pred_lasso)
print("Lasso Mean Squared error of the model is:", mselasso)

rmselasso = root_mean_squared_error(Y_test, Y_pred_lasso)
print("Lasso Root Mean Squared error of the model is:", rmselasso)

r2lasso = r2_score(Y_test, Y_pred_lasso)
print("Lasso R2 Score of the model is:", r2lasso)



maeelasticnet = mean_absolute_error(Y_test, Y_pred_elasticnet)
print("Elastic Net Mean Absolute error of the model is:", maeelasticnet)

mseelasticnet = mean_squared_error(Y_test, Y_pred_elasticnet)
print("Elastic Net Mean Squared error of the model is:", maeelasticnet)

rmseelasticnet = root_mean_squared_error(Y_test, Y_pred_elasticnet)
print("Elastic Net Root Mean Squared error of the model is:", rmseelasticnet)

r2elasticnet = r2_score(Y_test, Y_pred_elasticnet)
print("Lasso R2 Score of the model is:", r2elasticnet)


