## import all the necessary libraries
import numpy  as np
import pandas as pd
import matplotlib.pyplot as plt
import streamlit as st
from sklearn.datasets import load_iris
from sklearn.ensemble import RandomForestClassifier

### It is a decorator used in streamlit that stores the output of a function
@st.cache_data
def load_data():
    iris = load_iris()
    df = pd.DataFrame(iris.data, columns=iris.feature_names)
    df['species'] = iris.target
    return(df, iris.target_names)

df, target_names = load_data()

### call the object for RandomForestClassifier

model = RandomForestClassifier()

## train the model
x = df.iloc[:,:-1]
y = df['species']

model.fit(x,y)

st.sidebar.title("Input Features")
sepal_length = st.sidebar.slider("Sepal length", float(df['sepal length (cm)'].min()), float(df['sepal length (cm)'].max()))
sepal_width = st.sidebar.slider("Sepal width", float(df['sepal width (cm)'].min()), float(df['sepal width (cm)'].max()))
petal_length = st.sidebar.slider("Petal length", float(df['petal length (cm)'].min()), float(df['petal length (cm)'].max()))
petal_width = st.sidebar.slider("Petal width", float(df['petal width (cm)'].min()), float(df['petal width (cm)'].max()))

input_data = [[sepal_length, sepal_width, petal_length, petal_width]]

### prediction
prediction = model.predict(input_data)
predicted_species = target_names[prediction[0]]


st.write("Prediction")
st.write(f"The predicted species is: {predicted_species}")