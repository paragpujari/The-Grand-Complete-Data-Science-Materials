import joblib
import streamlit as st
import numpy     as np
import pandas    as pd

#### Load the Model
sc     = joblib.load("Standard_ranreg.pickle")
model  = joblib.load("Random_Forest_Regressor.pickle")


#### Write the title of the Streamlit Application
st.title("Random Forest Regressor")

#### Write the contents in the Streamlit Application
st.write("Predict the House Price based on the Housing features using Random Forest Regressor")

#### Enter the inputs of the Boston House Price
crim    = st.number_input("Crime Rate", 0.0, 100.0)
zn      = st.number_input("Residential Land Zone (%)", 0.0, 100.0)
indus   = st.number_input("Industrial Area (%)", 0.0, 30.0)
chas    = st.selectbox("Near River? (0 = No, 1 = Yes)", [0, 1])
nox     = st.number_input("Nitric Oxide Concentration", 0.0, 1.0)
rm      = st.number_input("Average Rooms per House", 1.0, 10.0)
age     = st.number_input("Age of Property (%)", 0.0, 100.0)
dis     = st.number_input("Distance to Employment Centers", 0.0, 15.0)
rad     = st.number_input("Accessibility to Highways", 1, 24)
tax     = st.number_input("Property Tax Rate", 0.0, 800.0)
ptratio = st.number_input("Pupil-Teacher Ratio", 10.0, 30.0)
b       = st.number_input("Proportion of Blacks", 0.0, 400.0)
lstat   = st.number_input("Lower Status Population (%)", 0.0, 40.0)


#### Predict the House Price based on the Housing Features
if(st.button("Predict Housing Price")):
    #### convert all the inputs into 2D array form
    input = np.array([[crim, zn, indus, chas, nox, rm, age, dis, rad, tax, ptratio, b, lstat]])

    #### scale the inputs
    scaled_input = sc.transform(input)

    #### predict the house price 
    predictions = model.predict(scaled_input)

    #### print the predicted house price
    st.success(f"Predicted House Price is: {predictions[0]:.2f}k")