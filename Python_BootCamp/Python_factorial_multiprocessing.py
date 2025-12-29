'''
Real-World Example: Multiprocessing for CPU-bound Tasks
Scenario: Factorial Calculation
Factorial calculations, especially for large numbers, 
involve significant computational work. Multiprocessing 
can be used to distribute the workload across multiple 
CPU cores, improving performance.

'''

import multiprocessing
import time
import math 



def factorial_number(numbers):
    res = math.factorial(numbers)
    print(f"Factorial of a number is:", res)
    return(res)

       

if __name__ == "__main__":
    numbers=[5000,6000,700,8000]

    start_time = time.time()

    with multiprocessing.Pool() as pool:
        results = pool.map(factorial_number, numbers)

    end_time = time.time()

    print(f"Results: {results}")

    print(f"Time Taken : {end_time - start_time} seconds")
