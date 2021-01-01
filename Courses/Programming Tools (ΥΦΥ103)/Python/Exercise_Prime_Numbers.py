def primes_list_until_number(n):
    # Input: n > 2 (integer)
    # Output: primes_list, contains all primes until n
    primes_list = []

    if n <= 2:
        raise ValueError('Input number n must be greater than 2')
    if not isinstance(n, int):
        raise ValueError('Input number n must be a natural number')

    for i in range(2, n+1):
        check = 1
        for j in range(2, i):
            if i % j == 0:
                check = 0
                break
        if check == 1:
            primes_list.append(i)

    return primes_list


# Demo code
number = 23
result = primes_list_until_number(number)
print(result)
