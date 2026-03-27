import joblib
import streamlit as st
import numpy     as np
import pandas    as pd

#### Load the Model
sc      = joblib.load("Standard_dectree.pickle")
dectree = joblib.load("dectree_tree.pickle")

#### Write the title of the Application
st.title("Decision Tree Classifier")

#### Write the content into the StreamlitApplication
st.write("Predict whether the person is having diabetes or not based on the diabetes condition using Decsion Tree Classifier")

#### Enter the inputs
pregnancies   = st.number_input("Pregnancies"             , min_value=0.0,step=0.5)
glucose       = st.number_input("Glucose"                 , min_value=0.0,step=0.5)
bloodpressure = st.number_input("BloodPressure"           , min_value=0.0,step=0.5)
skinthickness = st.number_input("SkinThickness"           , min_value=0.0,step=0.5)
insulin       = st.number_input("Insulin"                 , min_value=0.0,step=0.5)
bmi           = st.number_input("BMI"                     , min_value=0.0,step=0.5)
dpf           = st.number_input("DiabetesPedigreeFunction", min_value=0.0,step=0.5)
age           = st.number_input("Age"                     , min_value=0.0,step=0.5)


#### Predict whether the person is having diabetes or not
if(st.button("Predict Diabetes")):
    #### enter the input in 2D form
    input = np.array([[pregnancies, glucose, bloodpressure, skinthickness, insulin, bmi, dpf, age]])

    #### scale the inputs in one range
    scale_input_data = sc.transform(input)

    #### predict the model
    predictions = dectree.predict(scale_input_data)[0]

    probability = dectree.predict_proba(scale_input_data)[0][1]

    if(predictions == 1):
        st.error(f"High Risk of having  diabetes (Probability : {probability:.2f})")
    else:
        st.success(f"Low Risk of having  diabetes (Probability : {probability:.2f})")