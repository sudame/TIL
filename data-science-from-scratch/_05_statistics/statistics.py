from __future__ import division
from matplotlib import pyplot as plt
from collections import Counter
from _04_linear_algebra import vector, matrix
import math

num_friends = [
    100,
    49,
    41,
    40,
    25,
    21,
    21,
    19,
    19,
    18,
    18,
    16,
    15,
    15,
    15,
    15,
    14,
    14,
    13,
    13,
    13,
    13,
    12,
    12,
    11,
    10,
    10,
    10,
    10,
    10,
    10,
    10,
    10,
    10,
    10,
    10,
    10,
    10,
    10,
    10,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    9,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    7,
    6,
    6,
    6,
    6,
    6,
    6,
    6,
    6,
    6,
    6,
    6,
    6,
    6,
    6,
    6,
    6,
    6,
    6,
    6,
    6,
    6,
    6,
    5,
    5,
    5,
    5,
    5,
    5,
    5,
    5,
    5,
    5,
    5,
    5,
    5,
    5,
    5,
    5,
    5,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    3,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    2,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
]

friend_counts = Counter(num_friends)
xs = range(101)
ys = [friend_counts[x] for x in xs]
plt.bar(xs, ys)
plt.axis([0, 101, 0, 25])
plt.title("Histogram of Friend Counts")
plt.xlabel("# of friends")
plt.ylabel("# of people")
# plt.show()


num_points = len(num_friends)
largest_value = max(num_friends)
smallest_value = min(num_friends)

sorted_value = sorted(num_friends)
second_smallest_value = sorted_value[1]
second_largest_value = sorted_value[-2]


# 5.1.1 代表値
def mean(x):
    return sum(x) / len(x)


m = mean(num_friends)
print(m)


def median(v):
    n = len(v)
    sorted_v = sorted(v)
    midpoint = n // 2

    if n % 2 == 0:
        return sorted_v[midpoint]
    else:
        lo = midpoint - 1
        hi = midpoint
        return (sorted_v[lo] + sorted_v[hi]) / 2


m = median(num_friends)
print(m)


def quantile(x, p):
    p_index = int(p * len(x))
    return sorted(x)[p_index]


q_1 = quantile(num_friends, 0.10)
q_2 = quantile(num_friends, 0.25)
q_3 = quantile(num_friends, 0.75)
q_4 = quantile(num_friends, 0.90)
print(q_1)
print(q_2)
print(q_3)
print(q_4)


def mode(x):
    counts = Counter(x)
    max_count = max(counts.values())
    return [x_i for x_i, count in counts.items() if count == max_count]


m = mode(num_friends)
print(m)


# 5.1.2 散らばり


def data_range(x):
    return max(x) - min(x)


dr = data_range(num_friends)
print(dr)


def de_mean(x):
    x_bar = mean(x)
    return [x_i - x_bar for x_i in x]


def variance(x):
    n = len(x)
    deviations = de_mean(x)
    return vector.sum_of_squares(deviations) / (n - 1)


v = variance(num_friends)
print(v)


def standard_deviation(x):
    return math.sqrt(variance(x))


sd = standard_deviation(num_friends)
print(sd)


def interquartile_range(x):
    return quantile(x, 0.75) - quantile(x, 0.25)


ir = interquartile_range(num_friends)
print(ir)
