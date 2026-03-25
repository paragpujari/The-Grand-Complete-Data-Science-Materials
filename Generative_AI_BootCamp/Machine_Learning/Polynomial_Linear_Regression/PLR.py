import joblib
import streamlit as st
import numpy as np
import pandas as pd


#### define two models

poly = joblib.load("Polynomial_degree.pkl")

lin_poly = joblib.load("Linear_Regression.pkl")

### Write the title of the streamlit application
st.title("Polynomial Linear Regression")

#### Write the text in the Stremalit Application
st.write("Predict the salary based on the years of experience using PLR")

### Define the slider for years of experience
years = st.slider("Enter the years of experience:", 0.0, 20.0, 1.0)

### Transform the years of experience into the Polynomial form
exp_years = poly.transform([[years]])

### predict the salary for the years of experience
predictions = lin_poly.predict(exp_years)

### print the salary for the years of experience
st.write(f"Predicted Salary: ₹ {predictions[0]:,.2f}")