import joblib
import streamlit as st
import numpy     as np
import pandas    as pd

#### Load the model
sc  = joblib.load("Standard_random.pickle")
rcf = joblib.load("Random_Forest_Classifier.pickle")

#### Write the title of the Streamlit Application
st.title("Random Forest Classifier")

#### Write the content into the Streamlit Application
st.write("Predict whether the patient is having diabetes or not based on the diabetic condition")

#### Enter the inputs
pregnancies   = st.number_input("Pregnancies"             , min_value=0.0,step=0.5)
glucose       = st.number_input("Glucose"                 , min_value=0.0,step=0.5)
bloodpressure = st.number_input("BloodPressure"           , min_value=0.0,step=0.5)
skinthickness = st.number_input("SkinThickness"           , min_value=0.0,step=0.5)
insulin       = st.number_input("Insulin"                 , min_value=0.0,step=0.5)
bmi           = st.number_input("BMI"                     , min_value=0.0,step=0.5)
dpf           = st.number_input("DiabetesPedigreeFunction", min_value=0.0,step=0.5)
age           = st.number_input("Age"                     , min_value=0.0,step=0.5)


#### Predict whether the patient is suffering from diabetes or not
if(st.button("Predict Diabetes")):
    #### Convert all the inputs into 2D array
    input = np.array([[pregnancies, glucose, bloodpressure, skinthickness, insulin, bmi, dpf, age]])

    #### Scale the input
    scaled_input = sc.transform(input)

    ### Predict the model using the input
    predictions = rcf.predict(scaled_input)[0]
    probability = rcf.predict_proba(scaled_input)[0][1]

    if(predictions == 1):
        st.error(f"High Risk of having Diabetes : (Probability : {probability:.2f})")
    else:
        st.success(f"Low Risk of having Diabetes : (Probability : {probability:.2f})")