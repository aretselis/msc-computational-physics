import numpy as np
import matplotlib.pyplot as plt
from random_number_generators import linear_congruential_generator

# Input data
lambda_MCU = 3.17 * pow(10, -3)  # [per day, OMERE data]
MTTF_MCU = 1 / lambda_MCU  # [days]

# Define time domain

t_start = 0
t_end = 4 * MTTF_MCU
t_step = 1
time_domain = np.arange(t_start, t_end, t_step)


# Reliability function definition
def reliability_function(time, mttf):
    return np.exp(-time / mttf)


# Number of experiment runs
runs = 1000
random_numbers = linear_congruential_generator(0.02, runs)

# Calculate theoretical reliability at each time step
theoretical_reliability = []
for i in range(0, np.size(time_domain)):
    theoretical_reliability.append(reliability_function(time_domain[i], MTTF_MCU))

# Main Monte-Carlo Simulation
failure_time = []
working_devices = np.zeros(np.size(time_domain))
for i in range(0, runs):
    random_value = random_numbers[i]
    for j in range(0, np.size(time_domain)):
        if theoretical_reliability[j] < random_value:
            failure_time.append(time_domain[j])
            break
        working_devices[j] += 1

plt.figure()
plt.plot(time_domain, theoretical_reliability, label="Theoretical value")
plt.plot(time_domain, working_devices / runs, '.', markersize=2, label="Monte-Carlo Simulation")
plt.xlabel("Time, t, [days]")
plt.ylabel("Reliability, R, []")
plt.title("Case 1 \n Single MCU architecture")
plt.grid()
plt.legend()
plt.show()
