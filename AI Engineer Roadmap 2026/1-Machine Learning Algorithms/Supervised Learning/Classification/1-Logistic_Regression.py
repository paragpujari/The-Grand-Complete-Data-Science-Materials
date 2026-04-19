#### Logistic Regression

######  The main aim of this project is to predict whether the tumor is malignant or benign using end to end machine learning Logistic Regression project.

#####  Steps performed by this algorithm:

####   1.   Import all the necessary libraries

####   2.   Load the dataset

####   3.   Perform the Data Exploration

####   4.   Perform the Feature Engineering

####   5.   Divide the dataset into independent and dependent variables

####   6.   Divide the independent and dependent variables into training and testing data

####   7.   Perform Feature Scaling on the input data

####   8.   Train the model

####   9.   Predict the model on the test data

####   10.  Evaluate the model performance

####   11.  Predict whether the tumor is benign or malignant



############################# 1.    Import  all the necessary libraries ################################################################

import  numpy               as   np
import  pandas              as   pd
import  matplotlib.pyplot   as   plt
import  seaborn             as   sns

from    sklearn.datasets          import   load_breast_cancer
from    sklearn.model_selection   import   train_test_split
from    sklearn.preprocessing     import   StandardScaler
from    sklearn.linear_model      import   LogisticRegression
from    sklearn.metrics           import   accuracy_score, confusion_matrix, classification_report


############################ 2. Load the Dataset #######################################################################################

data = load_breast_cancer()

#### construct the dataframe from the above data

df = pd.DataFrame(data.data, columns = data.feature_names)

#### Adding the target to the dataset
df['target'] = data.target

print(df)


######## OBSERVATIONS ##########################

########  1. The dataset explains about the breast cancer tumor data and explains whether every record in the dataset is suffering from 

     #### (a.)  Malignant ----------->   Cancerous Data

     ### (b.)   Benign    ----------->   Benign Data


########################### 3. Perform the Data Exploration ##########################################################################

print("Length of the dataset is:", len(df))

print("Shape of the dataset is:", df.shape)

print(df.columns)

print(df.info())

print(df.describe())

print(df.describe())   ##### Statistical information for every numerical column in the dataset

print(df.corr())

sns.heatmap(df.corr(), annot=True)



######################## 4. Perform the Feature Engineering #########################################################################


print(df.isnull().sum())      ########## No NULL Values in the dataset

print(df[df.duplicated()])    ######### No duplicate records in the dataset


###################### 5. Divide the dataset into independent and dependent features ###############################################

####### independent features

X = df.drop(columns='target')

print(X)

###### dependent features

Y = df['target']

print(Y)



#####################  6. Divide the independent and dependent variables into training and testing data ############################

from  sklearn.model_selection  import  train_test_split

X_train, X_test, Y_train, Y_test = train_test_split(X,Y,test_size=0.2,random_state=42,stratify=Y)

print(X_train)

print(X_test)

print(X_train.shape)

print(X_test.shape)



print(Y_train)

print(Y_test)

print(Y_train.shape)

print(Y_test.shape)


#########################  7. Perform Feature Scaling on the input data #####################################

from  sklearn.preprocessing  import  StandardScaler

sc = StandardScaler()

X_train_scaled = sc.fit_transform(X_train)

X_test_scaled  = sc.transform(X_test)

print(X_train_scaled)

print(X_test_scaled)


########################  8.  Train the Logistic Regression Model ###########################################

from  sklearn.linear_model  import LogisticRegression

##### create the object for Logistic Regression

log = LogisticRegression(max_iter=1000)

#### train the model

log.fit(X_train_scaled, Y_train)



####################### 9. Predict the model on the test data ##############################################

Y_pred = log.predict(X_test_scaled)

print(Y_pred)


###################### 10. Evaluate the model performance #################################################

from  sklearn.metrics  import  accuracy_score, confusion_matrix, classification_report

ac = accuracy_score(Y_test, Y_pred)
print("Accuracy score of the model is:", (ac * 100.0))   ##### The accuracy of the model is very high. So it is fine.

cm = confusion_matrix(Y_test, Y_pred)
print("Confusion Matrix of the model is:", cm)

cr = classification_report(Y_test, Y_pred)
print("Classification report of the model is:", cr)


#######################  11. Predict whether the tumor is benign or malignant #############################################


sample = X_test_scaled[1].reshape(1,-1)

print(sample)

prediction = log.predict(sample)

print(prediction)

if(prediction[0] == 1):
    print("The tumor is malignant(Cancerous)")
else:
    print("The tumor is benign(Non Cancerous)")