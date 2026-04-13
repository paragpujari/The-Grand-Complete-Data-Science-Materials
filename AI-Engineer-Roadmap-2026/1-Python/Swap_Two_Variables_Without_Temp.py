###### Enter the two numbers

a = int(input("Enter the first number:"))
b = int(input("Enter the second number:"))

print("=========================================Before Swapping==========================================")

print("Value of first number is:", a)
print("Value of second number is:", b)

#### performing the swapping operation

a = a + b 
b = a - b 
a = a - b 

print("=========================================After Swapping==========================================")

print("Value of first number is:", a)
print("Value of second number is:", b)