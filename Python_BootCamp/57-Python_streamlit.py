### import all the necessary libraries
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import streamlit as st

### Write the title of the application
st.title("Hello Streamlit")

### Write the text message on the Streamlit application
st.write("This is the simple text.")

### create the simple dataframe
df = pd.DataFrame({
    'first column': [1, 2, 3, 4],
    'second column': [10, 20, 30, 40]
})

st.write("This is the simple dataframe")
st.write(df)

## create the line chart
chart_data=pd.DataFrame(
    np.random.randn(20,3),columns=['a','b','c']
)
st.line_chart(chart_data)