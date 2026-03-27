import joblib
import streamlit as st
import numpy     as np
import pandas    as pd


#### Load the Model
sc = joblib.load("StandardScalerLog.pickle")
log = joblib.load("LogisticRegression.pickle")

#### Write the title of the Streamlit Application
st.title("Logistic Regression Project")


#### Write the content into the Stremlit Application
st.write("Predict whether the person is having diabetes or not based on the diabetic condition")

#### Enter the inputs for the diabetic data
pregnancies   = st.number_input("Pregnancies"             , min_value=0.0,step=0.5)
glucose       = st.number_input("Glucose"                 , min_value=0.0,step=0.5)
bloodpressure = st.number_input("BloodPressure"           , min_value=0.0,step=0.5)
skinthickness = st.number_input("SkinThickness"           , min_value=0.0,step=0.5)
insulin       = st.number_input("Insulin"                 , min_value=0.0,step=0.5)
bmi           = st.number_input("BMI"                     , min_value=0.0,step=0.5)
dpf           = st.number_input("DiabetesPedigreeFunction", min_value=0.0,step=0.5)
age           = st.number_input("Age"                     , min_value=0.0,step=0.5)


#### Predict for the diabetic condition
if(st.button("Predict diabetic")):
    #### Convert all the input into the 2D array
    input = np.array([[pregnancies, glucose, bloodpressure,skinthickness, insulin, bmi, dpf, age]])
    #### Scale the input in one range
    input_scaled_data = sc.transform(input)
    #### Perform the prediction for the scaled input
    prediction = log.predict(input_scaled_data)[0]
    probability = log.predict_proba(input_scaled_data)[0][1]

    if(prediction == 1):
        st.error(f"High Risk of having diabetes (Probability : {probability:.2f})")
    else:
        st.success(f"Low Risk of having diabetes (Probability : {probability:.2f})")
