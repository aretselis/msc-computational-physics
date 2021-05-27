import numpy as np
import matplotlib.pyplot as plt
from random_number_generators import linear_congruential_generator

# Input data
lambda_MCU = 3.17 * pow(10, -3)  # [per day, OMERE data]
MTTF_MCU = 1 / lambda_MCU  # [days]

# Define time domain

t_start = 0
t_end = 6 * MTTF_MCU
t_step = 1
time_domain = np.arange(t_start, t_end, t_step)


# Reliability function definition
def system_reliability_function(time, mttf):
    return 1-((1-np.exp(-time / mttf))*(1-np.exp(-time / mttf)))


# Component reliability
def component_reliability_function(time, mttf):
    return np.exp(-time / mttf)


# Number of experiment runs
runs = 1000
random_numbers = linear_congruential_generator(0.742, runs+1)

# Calculate theoretical reliability at each time step
theoretical_system_reliability = []
theoretical_component_reliability = []
for i in range(0, np.size(time_domain)):
    theoretical_system_reliability.append(system_reliability_function(time_domain[i], MTTF_MCU))
    theoretical_component_reliability.append(component_reliability_function(time_domain[i], MTTF_MCU))

# Main Monte-Carlo Simulation
failure_time_system = []
working_devices = np.zeros(np.size(time_domain))
for i in range(0, runs):
    random_value_first = random_numbers[i]
    random_value_second = random_numbers[i+1]
    state_first_mcu = 1
    state_second_mcu = 1
    for j in range(0, np.size(time_domain)):
        if theoretical_component_reliability[j] < random_value_first:
            state_first_mcu = 0
        if theoretical_component_reliability[j] < random_value_second:
            state_second_mcu = 0
        if state_first_mcu == 0 and state_second_mcu == 0:
            failure_time_system.append(time_domain[j])
            break
        working_devices[j] += 1

plt.figure()
plt.plot(time_domain, theoretical_system_reliability, label="Theoretical value")
plt.plot(time_domain, working_devices / runs, '.', markersize=2, label="Monte-Carlo Simulation")
plt.xlabel("Time, t, [days]")
plt.ylabel("Reliability, R, []")
plt.title("Case 2 \n Dual MCU architecture (Hot Redundancy)")
plt.grid()
plt.legend()
plt.show()
