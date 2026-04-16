#####  To implement the Gradient descent 

###### Step 1: Import all the necessary libraries

import     numpy              as  np
import     pandas             as  pd
import     matplotlib.pyplot  as  plt
import     seaborn            as  sns

###### Step 2: Load the data

X = np.array([1,2,3,4,5])
Y = np.array([2,4,5,4,5])


##### Step 3: Initialize the parameters

m = 0
b = 0
a = 0.001
epochs = 1000
n = len(X)

#### Step 4: Perform the Gradient Descent

for i in range(epochs):
    Y_pred = (m*X)+b

    dm = (-2/n)*np.sum(X*(Y-Y_pred))
    db = (-2/n)*np.sum(Y-Y_pred)

    m = m - a*dm
    b = b - a*db 

print("Final m is:", m)
print("Final b is:", b)