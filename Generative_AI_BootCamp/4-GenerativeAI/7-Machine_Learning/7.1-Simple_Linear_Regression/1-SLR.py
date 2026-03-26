import joblib
import streamlit as st
import numpy     as np
import pandas    as pd

#### Load the model
lin = joblib.load("linear.pkl")

### Write the title of the Application
st.title("Simple Linear Regression Project")

### Write the content into the Simple Linear Regression Project
st.write("Predict the salary based on the years experience")

#### Enter the years experience as input
years =st.number_input("Enter the years experience:", min_value=0.0, step=0.5)

#### Predict the salary based on the years experience
if(st.button("predict salary")):
    #### enter the years experience as the input
    years = np.array([[years]])

    #### predict the salary based on the years experience
    predictions = lin.predict(years)

    #### print the prdicted salary
    st.success(f"Predicted Salary is : {predictions[0]:,.2f}")