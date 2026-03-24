import joblib
import streamlit as st
import numpy as np
import pandas as pd

#### load the model
model = joblib.load("salary_model.pkl")


#### Write the title of the streamlit application
st.title("Linear Regression Application")

#### Write the content into the Streamlit Application
st.write("Predict the salary based on the years of experience")

#### Enter the years of experience
years = st.number_input("Enter the years of experience", min_value=0.0,step=0.5)


#### predict the button
if(st.button("Predict salary")):
    #### convert the years of experience into 2 d form
    years = np.array([[years]])

    #### predict the salary using the years of experience
    predictions = model.predict(years)

    #### show the results
    st.success(f"Predicted salary is: {predictions[0]:,.2f}")