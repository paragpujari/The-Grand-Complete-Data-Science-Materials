import streamlit as st
import numpy     as np
import pandas    as pd
import joblib

#### Load the model
sc      =       joblib.load("Standard_log.pkl")
model   =       joblib.load("model.pkl")


st.title("Breast Cancer Prediction App")

st.write("Enter feature values below:")# Create inputs dynamically (30 features)
features = []

feature_names = [
    'radius_mean','texture_mean','perimeter_mean','area_mean','smoothness_mean',
    'compactness_mean','concavity_mean','concave points_mean','symmetry_mean','fractal_dimension_mean',
    'radius_se','texture_se','perimeter_se','area_se','smoothness_se',
    'compactness_se','concavity_se','concave points_se','symmetry_se','fractal_dimension_se',
    'radius_worst','texture_worst','perimeter_worst','area_worst','smoothness_worst',
    'compactness_worst','concavity_worst','concave points_worst','symmetry_worst','fractal_dimension_worst'
]

for name in feature_names:
    val = st.number_input(f"{name}", value=0.0)
    features.append(val)

features = np.array(features).reshape(1, -1)

# Prediction
if st.button("Predict"):
    prediction = model.predict(features)

    if prediction[0] == 1:
        st.error("Malignant (Cancer Detected)")
    else:
        st.success("Benign (No Cancer)")
