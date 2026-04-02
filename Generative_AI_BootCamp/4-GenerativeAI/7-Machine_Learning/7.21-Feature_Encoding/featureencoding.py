import streamlit as st
import numpy as np
import joblib

# Load model
sc  = joblib.load('Standard_encoding.pickle')
log = joblib.load('Logistic_encoding.pickle')

st.title("Customer Purchase Prediction")

age = st.slider("Age", 18, 60)
salary = st.number_input("Estimated Salary", 15000, 150000)
gender = st.selectbox("Gender", ["Male", "Female"])

# One-Hot Encoding manually
gender_male = 1 if gender == "Male" else 0

input_data = np.array([[age, salary, gender_male]])
input_scaled = sc.transform(input_data)

if st.button("Predict"):
    result = log.predict(input_scaled)
    if result[0] == 1:
        st.success("Customer will purchase")
    else:
        st.error("Customer will NOT purchase")