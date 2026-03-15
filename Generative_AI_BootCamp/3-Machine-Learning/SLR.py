#### Load the important libraries

import streamlit as st
import numpy     as np
import pandas    as pd
import joblib

#### Load the SLR Model

model = joblib.load("salary_model.pkl")


#### Write the title of the Model Application
st.title("Salary Prediction App")


### Write the contents into the Streamlit Application
st.write("Predict the salary based on years of experience using Simple Linear Regression")

### Enter the years of experience using streamlit
experience = st.number_input("Enter the years of experience", min_value=0.0)

#### Create a button for Predict salary
if(st.button("Predict Salary")):
    ### Based on the years of experience, get the predicted salary
    prediction = model.predict([[experience]])

    ### Display the predicted salary
    st.success(f"Predicted Salary is: {prediction[0]:,.2f}")