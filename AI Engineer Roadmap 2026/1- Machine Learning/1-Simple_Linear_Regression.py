##### To perform the Simple Linear Regression on the Salary Dataset

####### Step 1: Import all the necessary libraries

import  numpy               as    np
import  pandas              as    pd
import  matplotlib.pyplot   as    plt
import  seaborn             as    sns


###### Step 2: Load the dataset

df = pd.read_csv("Salary_Data.csv")


##### Step 3: Perform the Data Exploration

print("Length of the dataset is:", len(df))


print(df.head())

print(df.tail())

print(df.shape)

print(df.columns)

print(df.info())

print(df.describe())

print(df.corr())

print(sns.heatmap(df.corr(), annot=True))


##### Step 4: Perform the Data Cleaning

print(df.isnull().sum())

print(df[df.duplicated()])


##### Step 5: Divide the dataset into independent and dependent features

X = df.drop(columns='Salary')

Y = df['Salary']


##### Step 6: Divide the independent and dependent features into the training and testing features

from  sklearn.model_selection import train_test_split

X_train, X_test, Y_train, Y_test = train_test_split(X,Y,test_size=0.2,random_state=42)



##### Step 7: Perform the Feature Scaling on the inputs

from  sklearn.preprocessing  import  StandardScaler

sc = StandardScaler()


X_train_scaled  = sc.fit_transform(X_train)

X_test_scaled   = sc.transform(X_test)


##### Step 8: Train the Linear Regression Model

from  sklearn.linear_model  import LinearRegression

#### create an object for linear regression

lin = LinearRegression()


#### using the object for linear regression, train the model

lin.fit(X_train_scaled, Y_train)


#### Step 9: Perform the prediction on the model

Y_pred = lin.predict(X_test_scaled)

print(Y_pred)


##### Step 10:  Find out the slope and intercept of the model

print("Slope of the model is:", lin.coef_)
print("Intercept of the model is:", lin.intercept_)


##### Step 11:  Perform the regression evaluation metrics of the model

from sklearn.metrics  import  mean_absolute_error, mean_squared_error, root_mean_squared_error, r2_score

mae = mean_absolute_error(Y_test, Y_pred)

print("Mean absolute error of the model is:", mae)


mse = mean_squared_error(Y_test, Y_pred)

print("Mean squared error of the model is:", mse)


rmse = root_mean_squared_error(Y_test, Y_pred)

print("Root Mean squared error of the model is:", rmse)



r2 = r2_score(Y_test, Y_pred)

print("R2 Score  of the model is:", r2)