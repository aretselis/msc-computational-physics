import numpy as np


def power_method(matrix, desired_acc, max_iter):
    # Computes the largest eigenvalue of a matrix using the power method
    # Input is the desired matrix, desired accuracy and maximum amount of iterations allowed
    # Returns the largest eigenvalue
    print('Desired accuracy = ', desired_acc)
    print('Now computing max eigenvalue using power method...')
    n = len(matrix)
    x = np.zeros(n)
    for i in range(0, n):
        summation = 0
        for j in range(0, n):
            summation = summation + matrix[i][j]
        x[i] = summation
    # Normalize x and compute first eigenvalue
    lambda_previous = np.max(x)
    for i in range(0, n):
        x[i] = x[i] / lambda_previous
    # Main loop
    for iteration in range(0, max_iter):
        temp = np.matmul(matrix, x)
        x = temp
        lambda_now = np.max(x)
        for i in range(0, n):
            x[i] = x[i] / lambda_now
        e_a = np.abs((lambda_now - lambda_previous) / lambda_now) * 100
        if e_a < desired_acc:
            print('Accuracy achieved!')
            break
        if iteration == max_iter - 1:
            print('Maximum iteration reached without achieving accuracy!')
            break
        lambda_previous = lambda_now

    print('Largest eigenvalue is %.2f' % lambda_now)
    return lambda_now


def compute_eigenvector(matrix, eigenvalue):
    # Computes the eigenvector of a matrix for a given eigenvalue of the matrix
    # Input is the desired matrix and the corresponding eigenvalue
    # Returns the eigenvector
    n = len(matrix)
    ev = np.zeros(n)
    eigenvalue = int(eigenvalue)
    for i in range(0, n):
        matrix[i][i] = matrix[i][i] - eigenvalue
    # Since the problem of finding eigenvectors is like solving a linear system, we will use the gauss elimination
    # method to compute the matrix We will transform our matrix to an augmented one and we will use the code from
    # exercise 1 Due to the fact that we are dealing with a singular matrix, assume x=1
    matrix = np.insert(matrix, n, ev, axis=1)
    k = 1  # Assume x=1
    for i in range(0, n):
        matrix[i][n] = matrix[i][n] - matrix[i][k - 1]
        matrix[i][k - 1] = matrix[i][k - 1] - matrix[i][k - 1]
    matrix = np.delete(matrix, k - 1, 1)
    matrix = np.delete(matrix, k - 1, 0)
    ev = gauss_elimination(matrix)
    ev = np.insert(ev, 0, 1)  # Attach first element (x=1) to the eigenvector
    print('\nThe corresponding eigenvector is:')
    print(ev)


def gauss_elimination(matrix):
    # Performs gauss elimination
    # Input is a linear system as an augmented matrix
    # Returns the solution vector

    # Forward Elimination
    n = len(matrix)
    x = np.zeros(n)
    for k in range(0, n):
        matrix = pivoting(matrix, k)
        for i in range(k + 1, n):
            factor = matrix[i][k] / matrix[k][k]
            for j in range(0, n):
                matrix[i][j] = matrix[i][j] - factor * matrix[k][j]
            matrix[i][n] = matrix[i][n] - matrix[k][n] * factor
            # Backward substitution
    for i in range(n - 1, -1, -1):
        summation = 0
        for j in range(i, n):
            summation = summation + matrix[i][j] * x[j]
        x[i] = (matrix[i][n] - summation) / matrix[i][i]
    return x


def pivoting(matrix, k):
    # Performs pivoting for gauss elimination
    # Input is a linear system as an augmented matrix and counter k
    # Returns the matrix after pivoting is performed
    n = len(matrix)
    p = k
    big = np.absolute(matrix[k][k])
    for i in range(k + 1, n):
        dummy = np.absolute(matrix[i][k])
        if dummy > big:
            big = dummy
            p = i
    if p != k:
        for j in range(k, n):
            dummy = matrix[p][j]
            matrix[p][j] = matrix[k][j]
            matrix[k][j] = dummy
        dummy = matrix[p][n]
        matrix[p][n] = matrix[k][n]
        matrix[k][n] = dummy
    return matrix


# Driving code

alpha = np.array([[4., 1., 2., 1.],
                  [1., 7., 1., 0.],
                  [2., 1., 4., -1.],
                  [1., 0., -1., 3.]])
accuracy = pow(10, -3)
maximum_iterations = 100
max_eigenvalue = power_method(alpha, accuracy, maximum_iterations)
compute_eigenvector(alpha, max_eigenvalue)
