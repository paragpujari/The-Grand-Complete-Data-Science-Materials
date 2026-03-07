import streamlit as st
import pandas as pd

st.title("Streamlit Text Input")

# Text input
name = st.text_input("Enter your name:")

# Slider
age = st.slider("Select your age:", 0, 100, 25)
st.write(f"Your age is {age}.")

# Selectbox
options = ["Python", "Java", "C++", "JavaScript"]
choice = st.selectbox("Choose your favorite language:", options)
st.write(f"You selected {choice}.")

# Greeting
if name:
    st.write(f"Hello, {name}")

# Sample dataframe
data = {
    "Name": ["John", "Jane", "Jake", "Jill"],
    "Age": [28, 24, 35, 40],
    "City": ["New York", "Los Angeles", "Chicago", "Houston"]
}

df = pd.DataFrame(data)
st.write(df)

# File uploader
uploaded_file = st.file_uploader("Choose a CSV file", type="csv")

if uploaded_file is not None:
    df = pd.read_csv(uploaded_file)
    st.write(df)