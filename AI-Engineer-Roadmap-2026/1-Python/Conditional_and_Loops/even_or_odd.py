#### To check if the number is odd or even

def even_odd(number):
    if((number%2)==0):
        return("Even number")
    else:
        return("Odd number")

number = int(input("Enter the number"))
ans = even_odd(number)
print(ans)