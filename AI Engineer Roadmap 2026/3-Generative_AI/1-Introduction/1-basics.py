#### Syntax and Semantics in Python

### Video Outline:

#### Single line Comments and multiline comments

#### Definition of Syntax and Semantics

#### Basic Syntax Rules in Python

#### Understanding Semantics in Python

#### Common Syntax Errors and How to Avoid Them

#### Practical Code Examples

### Suntax ---->  Syntax refers to the set of rules that defines the combinations of symbols that are considered to be correctly structured programs in a language. In simpler terms, syntax is about the correct arrangement of words and symbols in a code.

### Semantics ---> Semantics refers to the meaning or the interpretation of the symbols, characters, and commands in a language. It is about what the code is supposed to do when it runs.



## Basic Syntax Rules In Python
## Case sensitivity- Python is case sensitive. It treats each and every word as different.

name = 'Parag'
Name = 'Nippon'

print(name)
print(Name)


'''Hi, My name is Parag.
I am currently residing in noida.
Please help me in completing the task.'''


####  Indentation

##### Indentation in Python is used to define the structure and hierarchy of the code. Unlike many other programming languages that use braces {} to delimit blocks of code, Python uses indentation to determine the grouping of statements. This means that all the statements within a block must be indented at the same level.


age = 18

if(age >= 18):
    print("Eligible to vote")


## This is a single line comment
print("Hello World")



## Line Continuation
##Use a backslash (\) to continue a statement to the next line
ans = 1+2+3+4+5+\
6+7+8

print(ans)


## Multiple Statements on a single line
x=5;y=10;z=x+y 
print(z)


##Understand  Semnatics In Python
# variable assignment
age=30
name="Parag"

print(age)
print(name)


print(type(age))
print(type(name))


## Type Inference
variable=10
print(variable)
variable="Parag"
print(variable)


age=32
if age>30:
    print(age)

## Code exmaples of indentation
if True:
    print("Correct Indentation")
    if False:
        print("This ont print")
    print("This will print")
print("Outside the if block")