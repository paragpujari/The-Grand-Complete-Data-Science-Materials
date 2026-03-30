import joblib
import streamlit as st
import numpy     as np
import pandas    as pd


##### Load the Model
sc  = joblib.load("Standard_Val.pickle")
log = joblib.load("Logistic_Val.pickle")

#### Write the title of the Streamlit Application
st.title("Customer Churn Prediction")

#### Write the content into the Streamlit Application
st.write("Predict whether the customer will churn or not")


#### Enter the inputs
gender                  = st.selectbox('Select the Gender',['Male','Female'])
seniorcitizen           = st.number_input('Senior Citizen (0 = No, 1 = Yes)', min_value=0, max_value=1)
partner                 = st.selectbox('Select the Partner',['Yes','No'])
dependents              = st.selectbox('Select the dependents',['Yes','No'])
tenure                  = st.number_input('Tenure', min_value=0)
phoneservice            = st.selectbox('Select the phone service', ['Yes','No'])
multiplelines           = st.selectbox('Select the multiple lines',['No phone service', 'Yes', 'No'])
internetservice         = st.selectbox('Select the internet service',['Fiber optic', 'DSL', 'No'])
onlinesecurity          = st.selectbox('Select the onlinesecurity', ['Yes','No'])
onlinebackup            = st.selectbox('Select the onlinebackup  ', ['Yes','No'])
deviceprotection        = st.selectbox('Select the  deviceprotection', ['Yes','No'])
techsupport             = st.selectbox('Select the  techsupport', ['Yes','No'])
streamingtv             = st.selectbox('Select the  streamingtv', ['Yes','No'])
streamingmovies         = st.selectbox('Select the  streamingmovies', ['Yes','No'])
Contract                = st.selectbox('Contract', ['Month-to-month', 'One year', 'Two year'])
PaperlessBilling        = st.selectbox('Paperless Billing', ['Yes', 'No'])
PaymentMethod           = st.selectbox('Payment Method',['Electronic check', 'Mailed check', 'Bank transfer (automatic)', 'Credit card (automatic)'])
MonthlyCharges          = st.number_input('Monthly Charges')
TotalCharges            = st.number_input('Total Charges')


#### Encoding

gender_map          = {'Male' : 1, 'Female' : 0}
yes_no_map          = {'Yes': 1, 'No': 0}
multiple_lines_map  = {'No phone service': 0, 'No': 1, 'Yes': 2}
internet_map        = {'DSL': 0, 'Fiber optic': 1, 'No': 2}
contract_map        = {'Month-to-month': 0, 'One year': 1, 'Two year': 2}
payment_map         = { 
    
    'Electronic check': 0,
    'Mailed check': 1,
    'Bank transfer (automatic)': 2,
    'Credit card (automatic)': 3
}


#### Apply encoding
gender              =   gender_map[gender]
partner             =   yes_no_map[partner]
dependents          =   yes_no_map[dependents]
phoneservice        =   yes_no_map[phoneservice]
onlinesecurity      =   yes_no_map[onlinesecurity]
onlinebackup        =   yes_no_map[onlinebackup]
deviceprotection    =   yes_no_map[deviceprotection]
techsupport         =   yes_no_map[techsupport]
streamingtv         =   yes_no_map[streamingtv]
streamingmovies     =   yes_no_map[streamingmovies]
PaperlessBilling    =   yes_no_map[PaperlessBilling]

multiplelines       =   multiple_lines_map[multiplelines]
internetservice     =   internet_map[internetservice]
Contract            =   contract_map[Contract]
PaymentMethod       =   payment_map[PaymentMethod]


#### Predict the churn or not
if(st.button("Predict Churn")):
    #### convert the input into 2d array
    input = np.array([[gender, seniorcitizen, partner, dependents, tenure,
        phoneservice, multiplelines, internetservice,
        onlinesecurity, onlinebackup, deviceprotection,
        techsupport, streamingtv, streamingmovies,
        Contract, PaperlessBilling, PaymentMethod,
        MonthlyCharges, TotalCharges]])
    
    ### perform the standard scaling on the inputs
    scaled_inputs = sc.transform(input)

    #### predict the model
    predictions = log.predict(scaled_inputs)[0]
    print(predictions)

    if(predictions == 1):
        st.error("Customer will churn")
    else:
        st.success("Customer will not churn")