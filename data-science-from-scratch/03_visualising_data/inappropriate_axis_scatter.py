from __future__ import division
from matplotlib import pyplot as plt

test_1_grades = [99, 90, 85,97, 80]
test_2_grades =[100, 85, 60, 90, 70]

plt.scatter(test_1_grades, test_2_grades)
plt.title("Axes Arn't Comparable")
plt.xlabel("test 1 grade")
plt.xlabel("test 2 grade")
plt.show()