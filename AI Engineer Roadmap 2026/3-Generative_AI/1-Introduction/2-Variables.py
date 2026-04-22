#### Variables

#####   Variables are fundamental elements in programming used to store data that can be referenced and manipulated in a program. In Python, variables are created when you assign a value to them, and they do not need explicit declaration to reserve memory space. The declaration happens automatically when you assign a value to a variable.

####   Video Outline:

####  1.    Introduction to Variables

####  2.    Declaring and Assigning Variables

####  3.    Naming Conventions

####  4.    Understanding Variable Types

####  5.    Type Checking and Conversion

####  6.    Dynamic Typing

####  7.    Practical Examples and Common Errors

a=100
print(a)


#### Declaring and assigning a variable

name = "Parag"
age  = 30
height = 5.6
is_student=False

print(name)
print(age)
print(height)
print(is_student)


## Naming Conventions
## Variable names should be descriptive
## They must start with a letter or an '_' and contains letter,numbers and underscores
## variables names case sensitive

##### Variables with letter

name = "Parag"

print(name)

##### Variables with letter or underscore

_name = "Parag"

print(_name)


##### Variables with letter,numbers and underscores

num123_data = "parag"

print(num123_data)

## case sensitivity

name = 'Parag'
Name = 'Pujari'

print(name)
print(Name)


##### Variables cannot start with a letter

## 1name= 'Parag'

## print(1name)

### @name = 'Parag'

### print(@name)


## Understnading Variable types
## Python is dynamically typed,type of a variable is determined at runtime
age=30 #int
height=5.6 #float
name="Parag" #str
is_student=True #bool


print(age)
print(type(age))



print(height)
print(type(height))


print(name)
print(type(name))


print(is_student)
print(type(is_student))


# Type conversion

print("=========================Before performing Type Conversion==========================================")

agenum = age
print(agenum)
print(type(agenum))

print("=========================After performing Type Conversion==========================================")

agestr = str(age)
print(agestr)
print(type(agestr))


## Dynamic Typing
## Python allows the type of a variable to change as the program executes

var = 10
print(var)
print(type(var))


var = 'Parag'
print(var)
print(type(var))


var = 3.142
print(var)
print(type(var))



## input

name = input("Enter your name ")
print(name)


age = int(input("Enter your age "))
print(age)


### Simple calculator
num1 = float(input("Enter first number: "))
num2 = float(input("Enter second number: "))

sum = num1 + num2 
diff = num1 - num2
pro = num1 * num2
div = num1 / num2 

print("Sum of two numbers is:", sum)
print("Difference between two numbers is:", diff)
print("Product of two numbers is:", pro)
print("Division between two numbers is:", div)