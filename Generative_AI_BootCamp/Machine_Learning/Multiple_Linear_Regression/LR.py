import joblib
import streamlit as st
import numpy     as np
import pandas    as pd

### Load the model
model = joblib.load("model.pkl")

### Get the title of the Streamlit Application
st.title("Multiple Linear Regression")


### Write the content into the Streamlit Application
st.write("Predict the House Price based on the Housing features using Multiple Linear Regression")


#### Enter all the input features

area      = st.number_input("Enter the area of the house is (sq ft)", min_value=0.0)
bedrooms  = st.number_input("Enter the bedrooms" , min_value=0.0)
bathrooms = st.number_input("Enter the bathrooms", min_value=0.0)
stories   = st.number_input("Enter the stories"  , min_value=0.0)


#### Predict button

if(st.button("Predict Salary")):
    ### convert all the input data in 2d array
    input = np.array([[area, bedrooms, bathrooms, stories]])

    ### make the predictions for the input data
    predictions = model.predict(input)

    ### predict the salary for the model
    st.success(f"Predicted Salary is: {predictions[0]:,.2f}")