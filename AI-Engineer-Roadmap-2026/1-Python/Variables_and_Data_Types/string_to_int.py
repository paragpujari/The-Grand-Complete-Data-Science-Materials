#### perform string to integer using try except

def string_to_integer(s):
    try:
        return(int(s))
    except ValueError:
        return None 


ans = string_to_integer("123")
print(ans)