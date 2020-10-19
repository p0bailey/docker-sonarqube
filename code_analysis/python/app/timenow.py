#!/usr/bin/env python3

from datetime import datetime
import sys

print(sys.version)

current_datetime = datetime.now()
print current_datetime
# print(current_datetime)

for i in range(10):
    print current_datetime
    # print(current_datetime)

    # if __name__ == '__main__':
    #     fibonaccy.main()
