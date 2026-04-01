############################  Step 1:  Import  all the necessary libraries ####################################################

import   streamlit          as  st
import   numpy              as  np
import   pandas             as  pd
import   matplotlib.pyplot  as  plt
import   seaborn            as  sns


from     sklearn.model_selection   import  train_test_split, GridSearchCV
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


######################## Step 5: Perform the Pipeline + Hyper Parameter Tuning #################################################

from  sklearn.pipeline  import Pipeline

#### object for pipeline

pipeline = Pipeline([
    ("sc" ,     StandardScaler())                               ,
    ("log",     LogisticRegression(max_iter=1000) )
])


##### object for GridSearchCV

param_grid = {
    'log__C'   : [0.01, 0.1, 1, 10]
}

grid = GridSearchCV(pipeline , param_grid, cv = 5, scoring='roc_auc')

#### Train the model using grid
grid.fit(X_train, Y_train)

##### Get the best parameters

params = grid.best_params_

##### Get the best estimator

best_models = grid.best_estimator_


##################### Step 6:  Write the contents into the Streamlit Application ########################################

st.title("Diabetes Prediction App")

st.write("To predict whether the person is suffering from diabetes or not based on the diabetic condition")



def user_input():
    pregnancies = st.sidebar.number_input("Pregnancies",0,20)
    glucose     = st.sidebar.number_input("Glucose"    ,0,200)
    bp = st.sidebar.number_input("Blood Pressure", 0, 150)
    skin = st.sidebar.number_input("Skin Thickness", 0, 100)
    insulin = st.sidebar.number_input("Insulin", 0, 900)
    bmi = st.sidebar.number_input("BMI", 0.0, 70.0)
    dpf = st.sidebar.number_input("Diabetes Pedigree Function", 0.0, 3.0)
    age = st.sidebar.number_input("Age", 1, 120)

    #### return the input in 2D array
    return(np.array([[pregnancies, glucose, bp,skin, insulin, bmi, dpf, age]]))


input_data = user_input()

####################### Step 7 : Predict the Diabetes #################################################
if(st.button("Predict diabetes")):
    prediction = best_models.predict(input_data)
    probability = best_models.predict_proba(input_data)[0][1]

    st.subheader("Result")
    st.write("Prediction:", "Diabetic" if prediction[0] == 1 else "Not Diabetic")
    st.write("Probability:", round(probability, 2))

##################### Step 8 : Perform the Evaluation Metrics ########################################\

Y_pred = best_models.predict(X_test)
Y_prob = best_models.predict_proba(X_test)[:,1]

st.header("Evaluate the Classification Metrics:")

st.write("Accuracy  is:", accuracy_score(Y_test, Y_pred))
st.write("Precision is:", precision_score(Y_test, Y_pred))
st.write("Recall    is:", recall_score(Y_test, Y_pred))
st.write("F1 Score  is:", f1_score(Y_test, Y_pred))
st.write("ROC AUC   is:", roc_auc_score(Y_test, Y_pred))