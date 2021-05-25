import matplotlib.pyplot as plt


def linear_congruential_generator(N):
    xn_prev = 0.5
    numbers_list = []
    for i in range(0, N):
        a = 1812433253
        M = pow(2, 64) - 1
        b = 89539
        xn_next = (a*xn_prev+b) % M
        numbers_list.append(xn_next/M)
        xn_prev = xn_next
    return numbers_list


numbers = 100
result = linear_congruential_generator(numbers)
plt.figure()
plt.hist(result)
plt.grid()
plt.show()
