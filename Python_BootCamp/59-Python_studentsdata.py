### import all the necessary libraries

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import streamlit as st

### title of the streamlit application
st.title("Streamlit Text Input")

### enter your name in the streamlit text box for the variable "name"
name = st.text_input("Enter your name:")

### enter your age
age = st.slider("Enter your age:", 0,100,25)

### write your age
st.write(f"Your age is: {age}.")


options = ["Python", "Java", "C++", "JavaScript"]
choice = st.selectbox("Choose your favorite language:", options)
st.write(f"You selected {choice}.")


if name:
    st.write(f"Hello, {name}")

### create a simple dataframe
data = {
    "Name": ["John", "Jane", "Jake", "Jill"],
    "Age": [28, 24, 35, 40],
    "City": ["New York", "Los Angeles", "Chicago", "Houston"]
}

df = pd.DataFrame(data)
df.to_csv("sampledata.csv")
st.write(df)


uploaded_file=st.file_uploader("Choose a CSV file",type="csv")

if(uploaded_file is not None):
    df = pd.read_csv(uploaded_file)
    st.write(df)