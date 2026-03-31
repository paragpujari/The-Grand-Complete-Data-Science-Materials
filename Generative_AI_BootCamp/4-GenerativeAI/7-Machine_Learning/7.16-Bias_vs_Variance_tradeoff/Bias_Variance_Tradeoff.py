#### import all the necessary libraries

import  numpy               as  np
import  pandas              as  pd
import  matplotlib.pyplot   as  plt
import  seaborn             as  sns
import  pickle

from    sklearn.model_selection   import   train_test_split
from    sklearn.preprocessing     import   StandardScaler, PolynomialFeatures
from    sklearn.linear_model      import   LinearRegression
from    sklearn.metrics           import   mean_absolute_error, mean_squared_error, root_mean_squared_error, r2_score
from    sklearn.pipeline          import   Pipeline


#### Load the Dataset
df = pd.read_csv("Salary_Data.csv")

#### Divide the dataset into independent and dependent variables

#### Independent variables
X  =   df.drop(columns='YearsExperience',axis=1)

#### Dependent variables
Y  =   df[['Salary']]


##### Divide the independent and dependent variables into the training and testing data

from  sklearn.model_selection import train_test_split

X_train , X_test, Y_train, Y_test = train_test_split(X,Y,test_size=0.2,random_state=42)


#### Create the Models for Bias vs Variance
degrees = [1, 5, 15]
models  = {}

for degree in degrees:
    model = Pipeline(
        [
            ("scaler", StandardScaler())              ,
            ("poly",PolynomialFeatures(degree=degree)),
            ("linear", LinearRegression())
        ]
    )
    #### using the model, train the model
    model.fit(X_train, Y_train)
    
    models[degree] = model
    
    ### perform the model evaluation
    Y_pred_train = model.predict(X_train)
    Y_pred_test  = model.predict(X_test)
    
    print(f"\n Degree {degree}")
    print("Train MSE is:", mean_squared_error(Y_train, Y_pred_train))
    print("Test  MSE is:", mean_squared_error(Y_test, Y_pred_test))

    print("Train MAE is:", mean_absolute_error(Y_train, Y_pred_train))
    print("Test  MAE is:", mean_absolute_error(Y_test, Y_pred_test))

    print("Train RMSE is:", root_mean_squared_error(Y_train, Y_pred_train))
    print("Test  RMSE is:", root_mean_squared_error(Y_test, Y_pred_test))


    print("Train R2 Score is:", r2_score(Y_train, Y_pred_train))
    print("Test  R2 Score is:", r2_score(Y_test, Y_pred_test))


# Step 4: Save Best Model (degree=5)
best_model = models[5]

with open("model.pkl", "wb") as f:
    pickle.dump(best_model, f)

print("\n✅ Model saved as model.pkl")

# Step 5: Visualization
X_plot = np.linspace(X.min(), X.max(), 100).reshape(-1, 1)

plt.scatter(X, Y, color='black', label='Data')

for degree, model in models.items():
    y_plot = model.predict(X_plot)
    plt.plot(X_plot, y_plot, label=f"Degree {degree}")

plt.legend()
plt.title("Bias vs Variance Tradeoff")
plt.show()