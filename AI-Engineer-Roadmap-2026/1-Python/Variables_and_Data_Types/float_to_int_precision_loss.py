#### Float to int using precision loss
def float_to_int(x):
    try:
        x = int(x)
        return(x)
    except ValueError:
        return(None)



ans = float_to_int(10.75)
print("After the Conversion is:", ans)



