############################  Step 1:  Import  all the necessary libraries ####################################################

import   streamlit          as  st
import   numpy              as  np
import   pandas             as  pd
import   matplotlib.pyplot  as  plt
import   seaborn            as  sns


from     sklearn.model_selection   import  train_test_split, GridSearchCV, KFold, cross_val_score
from     sklearn.preprocessing     import  StandardScaler
from     sklearn.linear_model      import  LogisticRegression
from     sklearn.pipeline          import  Pipeline
from     sklearn.metrics           import  accuracy_score, precision_score, recall_score, f1_score, roc_auc_score


############################# Step 2: Load the Dataset #########################################################################

url = "https://raw.githubusercontent.com/jbrownlee/Datasets/master/pima-indians-diabetes.data.csv"

#### define the column names
columns = ['Pregnancies', 'Glucose', 'BloodPressure', 'SkinThickness',
           'Insulin', 'BMI', 'DiabetesPedigreeFunction', 'Age', 'Outcome']


df = pd.read_csv(url, names=columns)




########################## Step 3: Divide the dataset into independent and dependent features ##################################

X = df.drop(columns = 'Outcome', axis = 1)

Y = df[['Outcome']]


######################### Step 4: Divide the independent and dependent features into training and testing data #################

from  sklearn.model_selection  import  train_test_split

X_train, X_test, Y_train, Y_test = train_test_split(X,Y,test_size=0.2,random_state=42,stratify=Y)


######################## Step 5: Create an object for Pipeline  + Cross Validation + Hyper Parameter Tuning #################################################################

pipeline = Pipeline([
    ("sc"    ,      StandardScaler())         ,
    ("model" ,      LogisticRegression(max_iter = 1000))
])

#### perform the cross validation

##### create an object for kfold

kfold = KFold(n_splits = 5, shuffle = True, random_state = 42)


### compute the cross validation 
cross = cross_val_score(
    pipeline                    ,
    X_train                     ,
    Y_train                     ,
    cv       =      kfold       ,
    scoring  =   'accuracy'
)

print("Cross Validation Score", cross)

mean_cross = np.mean(cross)

print("Average of all the Cross Validation Score is:", mean_cross)

#### Perform the Hyper Parameter Tuing

param_grid = {
    'model__C' : [0.01, 0.1, 1, 10]
}

grid = GridSearchCV(
    pipeline                ,
    param_grid              ,
    cv       =   5          ,
    scoring  =  'accuracy'
)


#### Using the object of grid serach cv, train the model
grid.fit(X_train, Y_train)

#### Get the best parameters for the models

print("Parameters are:", grid.best_params_)

#### Get the best model

best_model = grid.best_estimator_

print("Best Model is:", best_model)

st.title("Cross Validation Demo App")

st.write("Cross Validation Scores")
st.write(cross)
st.write("Mean CV Score:", np.mean(mean_cross))

st.sidebar.header("Input Features")


preg         = st.sidebar.number_input("Pregnancies",0,20)
glucose      = st.sidebar.number_input("Glucose"    ,0,200)
bp           = st.sidebar.number_input("Blood Pressure", 0, 150)
skin         = st.sidebar.number_input("Skin Thickness", 0, 100)
insulin      = st.sidebar.number_input("Insulin", 0, 900)
bmi          = st.sidebar.number_input("BMI", 0.0, 70.0)
dpf          = st.sidebar.number_input("Diabetes Pedigree Function", 0.0, 3.0)
age          = st.sidebar.number_input("Age", 1, 120)


input_data   =  np.array([[preg, glucose, bp, skin, insulin, bmi, dpf, age]])

if st.button("Predict"):
    prediction = best_model.predict(input_data)
    st.write("Prediction:", "Diabetic" if prediction[0] == 1 else "Not Diabetic")

# Final Accuracy
y_pred = best_model.predict(X_test)
st.write("Final Test Accuracy:", accuracy_score(Y_test, y_pred))