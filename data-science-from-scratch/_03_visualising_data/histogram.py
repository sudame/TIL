from __future__ import division
from matplotlib import pyplot as plt
import pprint
from collections import Counter

grades = [83, 95, 91, 87, 70, 0, 85, 82, 100, 67, 73, 77, 0]
decline = lambda grade: grade // 10 * 10

histgram = Counter(decline(grade) for grade in grades)

plt.bar([x for x in histgram.keys()], histgram.values(), 8)
plt.axis([-5, 105, 0, 5])

plt.show()
