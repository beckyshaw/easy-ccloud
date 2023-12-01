import random
import time

start = time.time()
num = random.randint(1, 100)   # Generates a random number that's either 0 or 1

while True:
    time.sleep(1)
    print('Deleting')
    time.sleep(3)
    print('          Complete')
    if time.time() - start > 500:
        print('Process finished')
        break
