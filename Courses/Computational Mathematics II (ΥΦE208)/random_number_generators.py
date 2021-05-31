import matplotlib.pyplot as plt


def linear_congruential_generator(xn_prev, N):
    numbers_list = []
    for i in range(0, N):
        a = 1812433253
        M = pow(2, 64) - 1
        b = 89539
        xn_next = (a*xn_prev+b) % M
        numbers_list.append(xn_next/M)
        xn_prev = xn_next
    return numbers_list


# numbers = 100000
# result = linear_congruential_generator(0.02, numbers)
# plt.figure()
# plt.hist(result)
# plt.grid()
#
# x_vector = [0.5]
# y_vector = [0.0]
# for i in range(0, numbers-1):
#     if i == 0:
#         y_vector[0] = result[i]
#     elif i%2==0:
#         y_vector.append(result[i])
#     else:
#         x_vector.append(result[i])
#
# plt.figure()
# plt.scatter(x_vector, y_vector)
# plt.grid()
# plt.show()
#
# c = []
# for i in range(1, 6):
#     sum = 0
#     for j in range(0, numbers-i):
#         sum += result[j]*result[j+i]
#     c.append(sum/j)
#
# print(c)