#### import all the necessary libraries
import  numpy             as  np
import  pandas            as  pd
import  matplotlib.pyplot as plt
import  seaborn           as sns


from    sklearn.model_selection  import  train_test_split
from    sklearn.preprocessing    import  StandardScaler
from    sklearn.linear_model     import  LinearRegression
from    sklearn.metrics          import  mean_absolute_error, mean_squared_error, root_mean_squared_error, r2_score

#### Load the dataset
df = pd.read_csv("Salary_Data.csv")


#### Divide the dataset into independent and dependent variables

X = df[['YearsExperience']]

Y = df[['Salary']]


#### Divide the independent and dependent variables into training and testing data

from  sklearn.model_selection  import  train_test_split

X_train, X_test, Y_train, Y_test = train_test_split(X,Y,test_size=0.2,random_state=42)


#### Scaling of all the input features

from  sklearn.preprocessing  import  StandardScaler

#### create an object for Standard Scaler

sc = StandardScaler()

X_train_scaled = sc.fit_transform(X_train)

X_test_scaled  = sc.transform(X_test)

#### Train the Linear Regression Model

from  sklearn.linear_model import LinearRegression

lin = LinearRegression()

### using the object of linear regression, train the model

lin.fit(X_train_scaled, Y_train)


#### Predict the output for the model based on the test data

Y_pred = lin.predict(X_test_scaled)

#### Evaluate the Model

mse = mean_squared_error(Y_test, Y_pred)

print("Mean Squared Error of the model is:", mse)

r2 = r2_score(Y_test, Y_pred)

print("R2 Score of the model is:", r2)


#### Plot regression line with predictions

plt.scatter(X,Y,color='green', label='Actual Data')
plt.plot(X,lin.predict(sc.transform(X)), color='red', label='Predicted Data')
plt.xlabel('YearsExperience')
plt.ylabel('Salary')
plt.title('Simple Linear Regression - Salary Prediction')
plt.legend()
plt.show()