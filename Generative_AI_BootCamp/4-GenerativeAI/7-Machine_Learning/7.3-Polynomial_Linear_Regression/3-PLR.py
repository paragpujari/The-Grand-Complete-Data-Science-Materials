import joblib
import streamlit as st
import numpy     as np
import pandas    as pd

#### Load the Model
poly     = joblib.load("Polynomial_Features.pkl")

lin_poly = joblib.load("Linear_Regression_for_Polynomial_Features.pkl")


#### Write the title of the Streamlit Application
st.title("Polynomial Linear Regression")

#### Write the text in the streamlit application
st.write("Predict the salary based on the years of experience using PLR")


#### Enter the years of experience as the input
years = st.number_input("Enter the years of experience", min_value=0.0, step=0.5)

#### Predict the salary based on the years of experience
if(st.button("Predict Salary")):
    #### Convert the input into 2D array
    years = np.array([[years]])

    #### Transform the input into Polynomial Features of degree 3
    years = poly.transform(years)

    #### using the years of experience, predict the salary
    predictions = lin_poly.predict(years)

    #### print the predicted salary
    st.success(f"Predicted Salary is {predictions[0]:,.2f}")