import numpy as np


def forward_num_derivative(matrix, h, rows, cols):
    # Forward finite-divided-difference first derivative
    # Achieves O(h^2) accuracy
    matrix[0][cols - 1] = (-matrix[0 + 2][cols - 2] + 4 * matrix[0 + 1][cols - 2] - 3 * matrix[0][cols - 2]) / (2 * h)
    return matrix


def backward_num_derivative(matrix, h, rows, cols):
    # Backward finite-divided-difference first derivative
    # Achieves O(h^2) accuracy
    matrix[rows - 1][cols - 1] = (3 * matrix[rows - 1][cols - 2] - 4 * matrix[rows - 2][cols - 2] + matrix[rows - 3][
        cols - 2]) / (2 * h)
    return matrix


def centered_num_derivative(matrix, h, rows, cols):
    # Centered finite-divided-difference first derivative
    # Achieves O(h^2) accuracy
    min_row = 1
    max_row = rows - 2
    for i in range(min_row, max_row + 1):
        matrix[i][cols - 1] = (matrix[i + 1][cols - 2] - matrix[i - 1][cols - 2]) / (2 * h)
    return matrix


def num_differentiation(matrix):
    # Achieves O(h^2) accuracy
    # Input is a matrix with first column being x value, second column being f(x) values
    # Returns the matrix with an additional column containing the corresponding f'(x) values
    dim = matrix.shape
    rows = dim[0]
    cols = dim[1]
    if rows < 3:
        raise ValueError('Less than three data points, cannot perform forward/backward/centered num differentiation')
    zero_v = np.zeros(rows)
    matrix = np.insert(matrix, cols, zero_v, axis=1)
    cols += 1
    h = matrix[1][0] - matrix[0][0]
    for i in range(1, rows):
        if matrix[i][0] - matrix[i - 1][0] - h < 0:
            print('Warning: Data are not equally spaced!')
    matrix = forward_num_derivative(matrix, h, rows, cols)
    matrix = backward_num_derivative(matrix, h, rows, cols)
    matrix = centered_num_derivative(matrix, h, rows, cols)
    return matrix


def simpson_simple_form(matrix):
    # Simple form of Simpson's h/3 rule
    # Input is a matrix with first column being x value, second column being f(x) values
    # Computes the integral at interval [x_min, x_max]
    # Returns integral value I
    dim = matrix.shape
    rows = dim[0]
    if (rows % 2) == 0:
        raise ValueError('Simpson\'s h/3 rule only works for an even number of segments!')
    cols = dim[1]
    middle = int(np.ceil(rows / 2))
    h = matrix[rows - 1][cols - 2] - matrix[0][cols - 2]
    I = h * (matrix[0][cols - 1] + (4 * matrix[middle - 1][cols - 1]) + matrix[rows - 1][cols - 1]) / 6
    return I


def simpson_multiple_form(matrix):
    # Multiple form of Simpson's h/3 rule
    # Input is a matrix with first column being x value, second column being f(x) values
    # Computes the integral at interval [x_min, x_max]
    # Returns integral value I
    dim = matrix.shape
    rows = dim[0]
    if (rows % 2) == 0:
        raise ValueError('Simpson\'s h/3 rule only works for an even number of segments!')
    cols = dim[1]
    middle = int(np.ceil(rows / 2))
    h = matrix[rows - 1][cols - 2] - matrix[0][cols - 2]
    odd_sum = 0
    even_sum = 0
    for i in range(1, rows, 2):  # stops at n-1
        odd_sum = odd_sum + matrix[i][cols - 1]
    for i in range(2, rows - 1, 2):  # stops at n-2
        even_sum = even_sum + matrix[i][cols - 1]
    f_x0 = matrix[0][cols - 1]
    f_xn = matrix[rows - 1][cols - 1]
    I = h * (f_x0 + 4 * odd_sum + 2 * even_sum + f_xn) / (3 * (rows - 1))
    return I


input_matrix = np.array([[1.8, 10.889365],
                         [1.9, 12.703199],
                         [2.0, 14.778112],
                         [2.1, 17.148957],
                         [2.2, 19.855030], ])

matrix_with_first_derivative = num_differentiation(input_matrix)
print('Numerical differentiation results:\n')
print(matrix_with_first_derivative)

integral_simple = simpson_simple_form(input_matrix)
integral_multiple = simpson_multiple_form(input_matrix)
print('\n Numerical integration results:')
print('\n Using simple form of Simpson\'s h/3 rule, I = %.7f' % integral_simple)
print('\n Using multiple form of Simpson\'s h/3 rule, I = %.7f' % integral_multiple)
