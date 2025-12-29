from concurrent.futures import ThreadPoolExecutor
import time 

def square_numbers(number):
    return(f"Square : {number ** 2}")


numbers = [1,2,3,4,5,6,7,8,9,11,2,3,12,14]
if __name__ == "__main__":
    with ThreadPoolExecutor(max_workers=3) as executor:
        results = executor.map(square_numbers, numbers)

        for x in results:
            print(x)