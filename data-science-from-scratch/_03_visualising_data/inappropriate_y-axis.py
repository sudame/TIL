from __future__ import division
from matplotlib import pyplot as plt

mentions = [500, 505]
years = [2013, 2014]

plt.bar ([2013, 2014], mentions, 0.8)
plt.xticks(years)

plt.ticklabel_format(useOffset=False)

plt.axis([2012.5, 2014.5, 499, 506])
plt.title("Look at the 'Huge' Increase!")
plt.show()