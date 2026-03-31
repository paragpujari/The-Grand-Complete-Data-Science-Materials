import streamlit as st
import numpy as np
import pickle
import matplotlib.pyplot as plt

# Load model
with open("model.pkl", "rb") as f:
    model = pickle.load(f)

st.title("Bias vs Variance Demo")

# Input
x_input = st.slider("Enter X value", -3.0, 3.0, 0.0)

# Prediction
prediction = model.predict(np.array([[x_input]]))

prediction_value = prediction.item()

st.write(f"Prediction: {prediction_value:.2f}")

# Plot
X = np.linspace(-3, 3, 100).reshape(-1, 1)
y = model.predict(X)

fig, ax = plt.subplots()
ax.plot(X, y)
ax.scatter([x_input], [prediction_value])

st.pyplot(fig)