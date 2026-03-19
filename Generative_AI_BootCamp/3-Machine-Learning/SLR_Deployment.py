import streamlit as st
import joblib
import numpy  as   np
import pandas as   pd

### Load the model
model = joblib.load("salary_model.pkl")


#### Write the title of the Streamlit Application
st.title("Salary Prediction App")

#### Write the content into the Streamlit Application page
st.write("Predict the salary based on the years of experience")

#### Enter the years of experience
years = st.number_input("Enter the years of experience", min_value=0.0, step=0.5)

### Prediction button
if(st.button("Predict Salary")):
    #### convert the years of experience as input into 2d array
    input = np.array([[years]])

    ### predict the salary using the years of experience as input
    prediction = model.predict(input)

    ### show the result
    st.success(f"Predicted Salary is: {prediction[0]:,.2f}")