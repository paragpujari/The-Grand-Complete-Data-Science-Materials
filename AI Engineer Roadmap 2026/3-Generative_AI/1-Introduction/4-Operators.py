####  Deep Dive into Operators

#####   Video Outline:
## Arithmethic Operation

a = 10
b = 5

add_result=a+b  #addiiton
sub_result=a-b  #substraction 
mult_result=a*b #multiplication
div_result=a/b  #division
floor_div_result=a//b ## floor division
modulus_result=a%b #modulus operation

exponent_result=a**b ## Exponentiation


print(add_result)
print(sub_result)
print(mult_result)
print(div_result)
print(floor_div_result)
print(modulus_result)
print(exponent_result)


## Relational Operation

print(a>b)
print(a<b)
print(a<=b)
print(a>=b)
print(a==b)
print(a!=b)


### Logical Operators

print((a <= b) and (a > b))
print((a <= b) or (a > b))
print((a <= b) or not(a > b))



## Simple Calculator

# Simple calculator
num1 = float(input("Enter first number: "))
num2 = float(input("Enter second number: "))

# Performing arithmetic operations
addition = num1 + num2
subtraction = num1 - num2
multiplication = num1 * num2
division = num1 / num2
floor_division = num1 // num2
modulus = num1 % num2
exponentiation = num1 ** num2

# Displaying results
print("Addition:", addition)
print("Subtraction:", subtraction)
print("Multiplication:", multiplication)
print("Division:", division)
print("Floor Division:", floor_division)
print("Modulus:", modulus)
print("Exponentiation:", exponentiation)