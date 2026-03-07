import streamlit as st
import pandas    as pd
import numpy     as np

### Display the title of the application
st.title("Hello Application")

### Display the header of the application
st.header("Welcome to Streamlit")

### Display the subheader of the application
st.subheader("This is a subheader")

## Diplay a Simple Text
st.write("Hi, my name is Parag Pujari.")

## create a simple Dataframe

df = pd.DataFrame({
    'first column': [1, 2, 3, 4],
    'second column': [10, 20, 30, 40]
})

### Display the Dataframe
st.write("This is the dataframe")
### Write the contents of the dataframe using streamlit
st.write(df)


### create a line chart

chart_data = pd.DataFrame(
    np.random.randn(20,3), columns=['a','b','c']
)
st.line_chart(chart_data)


### Design a button in such a way that when it is clicked , it should  display with a message that the button is clicked.

if st.button("Click me!"):
    ### display the message from the click
    st.write("The button is clicked")


### Design the checkbox , after clicking the checkbox, show the dataframe

show_data = st.checkbox("Show the DataFrame:")

if(show_data):
    st.write("Again display the dataframe:")
    st.write(df)


### Design the slider to select the value in the range

number = st.slider(
    "You selected:"        ,
    min_value = 0          ,
    max_value = 100        ,
    value     =  50
)

### display the slider value
st.write("You selected:", number)


### upload the file , if the file is not empty then read it

file_uploaded = st.file_uploader("Please upload a file:", type=["csv","txt"])

### check if the uploaded file is not empty then read it
if(file_uploaded is not None):
    df = pd.read_csv(file_uploaded)
    st.write(df.head())