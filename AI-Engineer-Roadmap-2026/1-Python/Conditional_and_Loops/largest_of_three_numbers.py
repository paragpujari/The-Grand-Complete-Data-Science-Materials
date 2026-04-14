####  Find the largest of three numbers

a = int(input("Enter the first number:"))
b = int(input("Enter the second number:"))
c = int(input("Enter the third number:"))

if(a>b):
    if(a>c):
        print(a,"is the largest")
    else:
        print(c,"is the largest")
else:
    if(b>c):
        print(b,'is the largest')
    else:
        print(c,"is the largest")
