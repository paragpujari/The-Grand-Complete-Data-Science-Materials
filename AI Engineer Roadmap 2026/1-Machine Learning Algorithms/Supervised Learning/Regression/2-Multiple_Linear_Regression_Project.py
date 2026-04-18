##### To perform the Multiple Linear Regression on the Housing Dataset that contains various features of the house


##### Step 1:   Import  all the necessary libraries

import  numpy              as  np
import  pandas             as  pd
import  matplotlib.pyplot  as  plt
import  seaborn            as  sns

from    sklearn.model_selection  import  train_test_split
from    sklearn.preprocessing    import  StandardScaler
from    sklearn.linear_model     import  LinearRegression
from    sklearn.metrics          import  mean_absolute_error, mean_squared_error, root_mean_squared_error, r2_score


##### Step 2:   Load the dataset

df = pd.read_csv("Housing.csv")

#### Step 3:    Perform the Data Exploration

print("Total length of the dataset is:", len(df))

print("Shape of the dataset is:", df.shape)

print(df.columns)

print(df.info())

print(df.describe())

print(df.head())

print(df.tail())


##### Step 4: Perform the Feature Engineering

df['mainroad']  = df['mainroad'].map({'yes':1, 'no':0})
df['guestroom'] = df['guestroom'].map({'yes':1, 'no':0})
df['basement']  = df['basement'].map({'yes':1, 'no':0})
df['hotwaterheating'] = df['hotwaterheating'].map({'yes':1, 'no':0})
df['airconditioning'] = df['airconditioning'].map({'yes':1, 'no':0})
df['prefarea'] = df['prefarea'].map({'yes':1, 'no':0})


from  sklearn.preprocessing  import  LabelEncoder

#### create an object for Label Encoder

label = LabelEncoder()


##### using the object for label encoder, train and test the model

df['furnishingstatus'] = label.fit_transform(df['furnishingstatus'])


print(df.head())

print(df.tail())


###### Step 5: Divide the dataset into independent and dependent features

X = df.drop(columns='price')

Y = df[['price']]

print(X)

print(Y)

###### Step 6: Divide the independent and dependent features into training and testing data

from  sklearn.model_selection  import  train_test_split

X_train, X_test, Y_train, Y_test = train_test_split(X,Y,test_size=0.2,random_state=42)


print(X_train)

print(X_test)


print(Y_train)

print(Y_test)


###### Step 7: Perform the Feature Scaling on the inputs

from  sklearn.preprocessing  import  StandardScaler

sc = StandardScaler()

X_train_scaled = sc.fit_transform(X_train)

X_test_scaled = sc.fit_transform(X_test)


print(X_train_scaled)

print(X_test_scaled)


##### Step 8:  Train the Linear Regression Model

from  sklearn.linear_model  import  LinearRegression

lin = LinearRegression()


#### using the object of linear regression model, train the model

lin.fit(X_train_scaled, Y_train)


##### Step 9: Predict the model

Y_pred_mul = lin.predict(X_test_scaled)

print(Y_pred_mul)


###### Step 10:  Perform the Regression Metrics

from  sklearn.metrics  import  mean_absolute_error, mean_squared_error, root_mean_squared_error, r2_score

mae = mean_absolute_error(Y_test, Y_pred_mul)

print("Mean Absolute error of the model is:", mae)


mse = mean_squared_error(Y_test, Y_pred_mul)

print("Mean Squared error of the model is:", mse)


rmse = root_mean_squared_error(Y_test, Y_pred_mul)

print("Root Mean Squared error of the model is:", rmse)


r2 = r2_score(Y_test, Y_pred_mul)

print("R2 Score of the model is:", r2)



###### Step 11: Perform the Regularization technique


from sklearn.linear_model import Ridge

ridge = Ridge(alpha=10)
ridge.fit(X_train_scaled, Y_train)
Y_pred_ridge = ridge.predict(X_test_scaled)
print(Y_pred_ridge)

###### Step 12:  Perform the Regression Metrics

from  sklearn.metrics  import  mean_absolute_error, mean_squared_error, root_mean_squared_error, r2_score

maeridge = mean_absolute_error(Y_test, Y_pred_ridge)

print("Mean Absolute error of the model is:", maeridge)


mseridge = mean_squared_error(Y_test, Y_pred_ridge)

print("Mean Squared error of the model is:", mseridge)


rmseridge = root_mean_squared_error(Y_test, Y_pred_ridge)

print("Root Mean Squared error of the model is:", rmseridge)


r2ridge = r2_score(Y_test, Y_pred_ridge)

print("R2 Score of the model is:", r2ridge)


from sklearn.linear_model import Lasso

lasso = Lasso(alpha=0.1)
lasso.fit(X_train_scaled, Y_train)
Y_pred_lasso = lasso.predict(X_test_scaled)
print(Y_pred_lasso)


###### Step 10:  Perform the Regression Metrics

from  sklearn.metrics  import  mean_absolute_error, mean_squared_error, root_mean_squared_error, r2_score

maelasso = mean_absolute_error(Y_test, Y_pred_lasso)

print("Mean Absolute error of the model is:", maelasso)


mselasso = mean_squared_error(Y_test, Y_pred_lasso)

print("Mean Squared error of the model is:", mselasso)


rmselasso = root_mean_squared_error(Y_test, Y_pred_lasso)

print("Root Mean Squared error of the model is:", rmselasso)


r2lasso = r2_score(Y_test, Y_pred_lasso)

print("R2 Score of the model is:", r2lasso)