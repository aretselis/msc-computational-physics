# Project 2021

## Introduction

As part of the class's workload, students taking the Data Analysis and Processing Using MATLAB class have to complete a project. For the academic year 2020/2021, the project is influenced by current affairs and relates to the COVID-19 pandemic. Due to the fact that I completed the majority of the optional weekly exercises for the course, I only had to complete half of the project.

## Project overview

Data in .xlsx format related to COVID-19 cases and deaths are provided, namely:

1. Covid19Confirmed.xlsx (for COVID-19 cases)
2. Covid19Deaths.xlsx (for COVID-19 deaths)

These data originate from the [European Center for Disease Control (ECDC)](https://www.ecdc.europa.eu/en/publications-data/download-todays-data-geographic-distribution-covid-19-cases-worldwide) and were extracted on 13/12/2020. The .xlsx files contain the cases or deaths per day for a large a number of countries from 01/01/2020 until 13/12/2020. The complete project description can be found (in Greek) in the .pdf file contained in this directory (Project2021.pdf). Brief explanations for the exercises completed by me will be provided below in English.

## Exercise 1

### Overview

In exercise 1, the student has to pick one European country based on their registry number (AEM). For me, the corresponding country was Croatia. Students then have to read the data for the COVID-19 cases and deaths and then select five different parametric distributions and figure out which one is the best to explain the data based on chi-square goodness-of-fit tests or mean-squared error (due to low p-values returned from the chi-square test). This analysis is conducted independently for COVID-19 cases and deaths. Actual results are provided by running `Exe1_best_parametric_fit.m` and visual results are provided as a quick reference below:


### Required files

1. Main program: `Exe1_best_parametric_fit.m`
2. Required supporting functions:
   - `read_condition_data.m`
   - `wave_detect.m` 


## Exercise 2

### Overview

In Exercise 2, the student has verify if the distribution chosen in Exercise 1 can explain the data for a large number (>10) of European countries. This analysis again uses chi-square goodness-of-fit tests and/or mean-squared error and is also performed independently for COVID-19 cases and deaths. The main program prints the corresponding results and the user can then interpret the results.

### Required files

1. Main program: `Exe2_verify_best_parametric_fit.m`
2. Required supporting functions:
   - `read_condition_data.m`
   - `wave_detect.m` 

## Exercise 3

### Overview

In Exercise 3, the lag time between COVID-19 cases and deaths is investigated. For the countries chosen in Exercise 2, the peak date for each country's COVID-19 cases wave and COVID-19 deaths wave is calculated and the lag time is extracted. For this sample we can then calculate 95% confidence intervals for the lag time using both parametric and bootstrap approaches. 

### Required files

1. Main program: `Exe3_lag_time_parametric_bootstrap.m`
2. Required supporting functions:
   - `read_condition_data.m`
   - `wave_detect_silent.m`
   - `peak_date.m`

## Exercise 4

### Overview

In Exercise 4, the lag time between COVID-19 cases and deaths is investigated again but now using a different approach. If COVID-19 cases are represented as x(t) and COVID-19 deaths are represented y(t) and we assume that the peak date for deaths comes at a later date (after lag time τ), we can investigate a range of values for τ and figure out for which value τ the Pearson correlation coefficient ρ is maximized for x(t) and y(t+τ). The value τ which results in the highest Pearson correlation coefficient is then the lag time. This analysis is repeated for 6 countries and the results are compared with the ones from Exercise 3. For visual reference, two diagrams for France and Finland are provided:

### Required files

1. Main program: `Exe3_lag_time_parametric_bootstrap.m`
2. Required supporting functions:
   - `read_condition_data.m`
   - `wave_detect_silent.m`
   - `peak_date.m`
   - `visualize_max_pearson.m`
