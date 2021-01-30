import numpy as np


def gauss_elimination(matrix):
    # Performs gauss elimination
    # Input is a linear system as an augmented matrix
    # Returns the solution vector

    # Forward Elimination
    x = np.zeros(4)
    n = len(matrix)
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

aug_mat = np.array([[1., -1., 2., -1., -8.],
                    [2., -2., 3., -3., -20.],
                    [1., 1., 1., 0., -2.],
                    [1., -1., 4., 3., 4.]])

solution = gauss_elimination(aug_mat)

print('\nSolution vector')
print(solution)

print('\nThe solution is:\n')
for i in range(len(solution)):
    print("x_", i + 1, "=", round(solution[i]))
