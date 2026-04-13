#### Aim:----To implement the Multiple linear regression on a Housing dataset

##### Step 1:  Import  all the necessary libraries

import  numpy             as  np
import  pandas            as  pd
import  matplotlib.pyplot as  plt
import  seaborn           as  sns

from    sklearn.model_selection  import  train_test_split
from    sklearn.preprocessing    import  StandardScaler
from    sklearn.linear_model     import  LinearRegression
from    sklearn.metrics          import  mean_absolute_error, mean_squared_error, root_mean_squared_error, r2_score


#### Step 2:  Load the dataset

df = pd.read_csv("Housing.csv")



#### Observations:-- We need to use the Multiple linear regression and based on all the housing features, we need to predict the price of the house.

##### Step 3:  Perform all the Data Exploration

##### display the dataset

###############   Handle Outliers
q1 = df['price'].quantile(0.25)
q3 = df['price'].quantile(0.75)

iqr = q3 - q1
print(iqr)

df = df[(df['price'] >= (q1 - (1.5 * iqr))) & (df['price'] <= (q3 + (1.5 * iqr)))]

print(sns.boxplot(df['price']))
plt.show()   ##### There are some outliers in the dataset

##### get the length of the dataset

print("Length of the dataset is:", len(df))


##### get the shape of the dataset

print("Shape of the dataset is:", df.shape)


##### get the top five rows of the dataset

print(df.head())

##### get the bottom five rows of the dataset

print(df.tail())

##### get all the information about the columns used in the dataset

print(df.info())


#### get the statistical information about all the data used in the dataset

print(df.describe())


#### Step 4: Perform the Data Cleaning and Feature Engineering


###### To check if there are any NULL records used in the dataset

print(df.isnull().sum())

#### To check for the duplicate records used in the dataset

print(df[df.duplicated()])

##### To convert all the categorical fectures into numerical features

df['mainroad'] = df['mainroad'].map({'yes':1,'no':0})
df['guestroom'] = df['guestroom'].map({'yes':1,'no':0})
df['basement'] = df['basement'].map({'yes':1,'no':0})
df['hotwaterheating'] = df['hotwaterheating'].map({'yes':1,'no':0})
df['airconditioning'] = df['airconditioning'].map({'yes':1,'no':0})
df['prefarea'] = df['prefarea'].map({'yes':1,'no':0})


from  sklearn.preprocessing  import LabelEncoder

label = LabelEncoder()

#### perform the label encoding on the furnishingstatus

df['furnishingstatus'] = label.fit_transform(df['furnishingstatus'])



##### Step 5: Divide the dataset into independent and dependent features

##### independent features

X = df.drop(columns='price')

##### dependent features

Y = df['price']

##### Step 6: Divide the independent and dependent features into training and testing data

from  sklearn.model_selection  import  train_test_split

X_train, X_test, Y_train, Y_test  = train_test_split(X,Y,test_size=0.2,random_state=42)

print(X_train)

print(X_test)

print(X_train.shape)

print(X_test.shape)



print(Y_train)

print(Y_test)

print(Y_train.shape)

print(Y_test.shape)


##### Step 7: Perform Feature Scaling on the input

from  sklearn.preprocessing  import  StandardScaler

sc = StandardScaler()

X_train_scaled = sc.fit_transform(X_train)

X_test_scaled  = sc.transform(X_test)


print(X_train_scaled)

print(X_test_scaled)


##### Step 8:  Train the Linear Regression Model

from  sklearn.linear_model import  LinearRegression

lin = LinearRegression()

lin.fit(X_train_scaled, Y_train)


###### Step 9: Predict the Model

Y_pred = lin.predict(X_test_scaled)

print(Y_pred)


##### Step 10: Evaluate the Regression Metrics

from  sklearn.metrics import  mean_absolute_error, mean_squared_error, root_mean_squared_error, r2_score

mae = mean_absolute_error(Y_test, Y_pred)

print("Mean Absolute error of the model is:", mae)


mse = mean_squared_error(Y_test, Y_pred)

print("Mean Squared error of the model is:", mse)


rmse = root_mean_squared_error(Y_test, Y_pred)

print("Root Mean Squared error of the model is:", rmse)


r2 = r2_score(Y_test, Y_pred)

print("R2 Score error of the model is:", r2)



########## Step 11: Perform Regularization on the above dataset

from sklearn.linear_model import Ridge, Lasso, ElasticNet


#### create an object for Ridge Regression

ridge = Ridge(alpha=1.0)

ridge.fit(X_train_scaled, Y_train)

Y_pred_ridge = ridge.predict(X_test_scaled)

mae_ridge = mean_absolute_error(Y_test, Y_pred_ridge)

print("Mean Absolute error of the model is:", mae_ridge)


mse_ridge = mean_squared_error(Y_test, Y_pred_ridge)

print("Mean Squared error of the model is:", mse_ridge)


rmse_ridge = root_mean_squared_error(Y_test, Y_pred_ridge)

print("Root Mean Squared error of the model is:", rmse_ridge)


r2_ridge = r2_score(Y_test, Y_pred_ridge)

print("R2 Score error of the model is:", r2_ridge)





#### create an object for Lasso Regression

lasso = Lasso(alpha=0.1)

lasso.fit(X_train_scaled, Y_train)

Y_pred_lasso = lasso.predict(X_test_scaled)

mae_lasso = mean_absolute_error(Y_test, Y_pred_lasso)

print("Mean Absolute error of the model is:", mae_lasso)


mse_lasso = mean_squared_error(Y_test, Y_pred_lasso)

print("Mean Squared error of the model is:", mse_lasso)


rmse_lasso = root_mean_squared_error(Y_test, Y_pred_lasso)

print("Root Mean Squared error of the model is:", rmse_lasso)


r2_lasso = r2_score(Y_test, Y_pred_lasso)

print("R2 Score error of the model is:", r2_lasso)



#### create an object for Elastic Net Regression

elasticnet = ElasticNet(alpha=0.1, l1_ratio=0.5)

elasticnet.fit(X_train_scaled, Y_train)

Y_pred_elasticnet = elasticnet.predict(X_test_scaled)

mae_elasticnet = mean_absolute_error(Y_test, Y_pred_elasticnet)

print("Mean Absolute error of the model is:", mae_elasticnet)


mse_elasticnet = mean_squared_error(Y_test, Y_pred_elasticnet)

print("Mean Squared error of the model is:", mse_elasticnet)


rmse_elasticnet = root_mean_squared_error(Y_test, Y_pred_elasticnet)

print("Root Mean Squared error of the model is:", rmse_elasticnet)


r2_elasticnet = r2_score(Y_test, Y_pred_elasticnet)

print("R2 Score error of the model is:", r2_elasticnet)



##### Step 12:  Perform the Data Visualization

plt.scatter(Y_test, Y_pred)
plt.xlabel("Actual Price")
plt.ylabel("Predicted Price")
plt.title("Actual vs Predicted")
plt.show()


residuals = Y_test - Y_pred

sns.scatterplot(x=Y_pred, y=residuals)
plt.axhline(y=0, color='r', linestyle='--')
plt.xlabel("Predicted")
plt.ylabel("Residuals")
plt.title("Residual Plot")
plt.show()