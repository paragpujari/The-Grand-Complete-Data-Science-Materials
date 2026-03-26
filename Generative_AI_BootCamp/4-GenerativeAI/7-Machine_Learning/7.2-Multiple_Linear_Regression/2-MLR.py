import joblib
import streamlit as st
import numpy     as np
import pandas    as pd


#### Load the model
lin = joblib.load("multiple_linear.pkl")


#### Write the Title of the Application
st.title("Multiple Linear Regression Project")

#### Write the contents into the streamlit Application
st.write("Predict the House Price based on all the input housing features")

#### enter the input features
area      =  st.number_input("Enter the area      of the house:", value=0.0)
bedrooms  =  st.number_input("Enter the bedrooms  of the house:", value=0.0)
bathrooms =  st.number_input("Enter the bathrooms of the house:", value=0.0)
stories   =  st.number_input("Enter the stories of the house:",   value=0.0)

### Predict the salary based on the Housing features
if(st.button("Predict Salary")):
    #### convert all the input features into 2D array
    input_data = np.array([[area, bedrooms, bathrooms, stories]])

    #### predict the house price based on all the input features
    predictions = lin.predict(input_data)

    #### print the predicted house price
    st.success(f"Predicted House Price is:{predictions[0]:,.2f}")