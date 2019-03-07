from matplotlib import pyplot as plt

names = ["Mikihiro", "Takehiro", "Hiroko", "Hiroyuki", "Masamune"]
age = [21, 18, 53, 50, 4]

xs = [i + 0.1 for i,_ in enumerate(names)]

plt.bar(xs, age)

plt.ylabel("# of Age")
plt.title("Age of SUDA family")

plt.xticks([i + 0.1 for i, _ in enumerate(names)], names)

plt.show()