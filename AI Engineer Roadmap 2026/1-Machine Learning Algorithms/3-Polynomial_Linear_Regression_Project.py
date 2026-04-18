#### Write a program based on Polynomial Linear Regression to predict the salaries of all the employees based on the positional levels in their companies.

#######     The main aim of this project is to develop a simple end to end Polynomial Linear Regression so as to predict the salaries of the employees based on the positional level in their companies.

#######     Here we are adding the non linear features into the model and it models the non-linear relationship between the independent and dependent features.

#######     The above Polynomial Linear Regression is more effective and complex than the simple linear regression.

#######     Steps performed by this algorithm:-


### (i) Import all the necessary libraries

### (ii) Load the dataset

### (iii) Perform EDA

### (iv) Divide the dataset into independent and dependent variables

### (v) Divide the data into training and testing data if available

### (vi) Train the model using Linear Regression

### (vii) Visualize Linear Regression Results

### (viii) Fit a Polynomial Regression Model and then train using SLR.

### (ix) Visualize Polynomial Linear Regression Results

### (x) Model Evaluation



##### Step 1: Import  all the necessary libraries

import numpy             as np
import pandas            as pd
import matplotlib.pyplot as plt
import seaborn           as sns


from   sklearn.model_selection import train_test_split
from   sklearn.preprocessing   import StandardScaler, PolynomialFeatures
from   sklearn.metrics         import mean_absolute_error, mean_squared_error, root_mean_squared_error, r2_score


##### Step 2: Load the dataset

df = pd.read_csv("Position.csv")


##### Step 3: Perform the Data Exploration

print(df.head())

print(df.tail())

print("Total number of records used in the dataset is:", len(df))

print(df.shape)

print(df.columns)

print(df.info())

print(df.corr(numeric_only=True))   #### It is used to obtain the relationship between all the numerical values

#sns.heatmap(df.corr(numeric_only=True))



##### Step 4: Perform the Data Cleaning

print(df.isnull().sum())

print(df[df.duplicated()])


##### Step 5: Divide the dataset into independent and dependent variables

X = df[['Level']].values

print(X)

Y = df[['Salary']].values 

print(Y)

##### Step 6: As the dataset is very small, the dataset cannot be divided into the training and testing data


##### Step 7: Train the Linear Regression Model

from  sklearn.linear_model  import  LinearRegression

lin = LinearRegression()


#### using the object of linear regression train the model

lin.fit(X,Y)


###### Step 8: Visualize the Linear Regression Results

plt.scatter(X,Y,color='red', label='actual data')
plt.plot(X,lin.predict(X),color='green', label='best fit of line')
plt.title("Linear Regression Result")
plt.xlabel("Position Label")
plt.ylabel("Salary")
plt.show()


###### Step 9:  Fit a Polynomial Regression Model and then train using SLR

from  sklearn.preprocessing  import  PolynomialFeatures

#### create an object using PolynomialFeatures

poly = PolynomialFeatures(degree=4)

#### using the object of Polynomial Regression, transform the input

X_poly = poly.fit_transform(X)

print(X_poly)


###### Step 10: Using the Polynomial Input, train the model

from  sklearn.linear_model  import  LinearRegression

lin_poly = LinearRegression()

lin_poly.fit(X_poly,Y)


###### Step 11:  Visualize Polynomial Linear Regression Results

## plot the actual data points

X_grid = np.arange(X.min(), X.max(), step=0.1)
X_grid = X_grid.reshape(-1, 1)

plt.scatter(X, Y, color = 'red', label = 'actual data')

## perform the best line of fit
plt.plot(X_grid, lin_poly.predict(poly.transform(X_grid)), color = 'green', label = 'Label Fit')

## title of the graph
plt.title("Polynomial Linear Regression Result")

## X Axis
plt.xlabel("Position Label")

## Y Axis
plt.ylabel("Salary")

## display the graph
plt.show()



