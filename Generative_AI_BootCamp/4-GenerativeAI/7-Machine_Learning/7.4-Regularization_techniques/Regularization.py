import joblib
import streamlit as st
import numpy as np
import pandas as pd

### Load the Model
sc         = joblib.load("Standard.pickle")
lasso      = joblib.load("Lasso.pickle")
ridge      = joblib.load("Ridge.pickle")
elasticnet = joblib.load("ElasticNet.pickle")


#### Write the title of the Application
st.title("Performing Regularization techniques")

#### Write the content into the Streamlit Application
st.write("Predict the salary based on the years of experience using the regularization techniques")

#### Choose the Appropriate Model
model_selection = st.selectbox("Choose your model", ["Ridge", "Lasso", "ElasticNet"])

#### Enter the YearsExperience as the input
years = st.number_input("Enter the years of experience:", min_value=0.0, step=0.5)

#### Predict the salary by clicking on the button
if(st.button("Predict Salary")):
    #### enter the years experience in the form of 2d array
    years = np.array([[years]])
    #### convert the 2d array in one scale
    years_scaled = sc.transform(years)

    #### Check the predicted value based on the model chosen
    if(model_selection == "Ridge"):
        prediction = ridge.predict(years_scaled)
    elif(model_selection == "Lasso"):
        prediction = lasso.predict(years_scaled)
    else:
        prediction = elasticnet.predict(years_scaled)

    ### print the predicted salary
    st.success(f"Predicted Salary is:{prediction[0]:,.2f}")