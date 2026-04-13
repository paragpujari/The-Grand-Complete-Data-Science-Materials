#### To swap two numbers using the third variable

###### Enter the two numbers

a = int(input("Enter the first number:"))
b = int(input("Enter the second number:"))

print("========================Before Swapping====================================")

print("First  number before swapping is:", a)
print("Second number before swapping is:", b)


##### perform the swapping operation

temp = a 
a    = b 
b    = temp


print("=========================After Swapping=====================================")


print("First  number after swapping is:", a)
print("Second number after swapping is:", b)