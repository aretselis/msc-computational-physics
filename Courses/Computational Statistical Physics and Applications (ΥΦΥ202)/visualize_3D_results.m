clear; clc; close all; 

raw_input = readmatrix("iterative_medical_vaccinated.csv");
raw_input = sortrows(raw_input);

% Define Column Rows

run_column = 1;
masks_n95_column = 2;
masks_medical_column = 3;
masks_homemade_column = 4;
percent_vaccinated_column = 5;
step_column = 6;
max_affected_column = 7;

% Read data
main_data = raw_input(3:end-1,...
    [masks_medical_column percent_vaccinated_column max_affected_column step_column run_column]);

main_data = sortrows(main_data);
vaccination = unique(main_data(:,2));
masks_usage = unique(main_data(:,1));
runs = unique(main_data(:,5));
runs(isnan(runs),:) = []; 

% Get what we need from each run

final_data = zeros(length(runs), 5); 

for i=1:length(runs)
    row = find(main_data(:,5)== i);
    temp_storage = main_data(row, :);
    final_data(i, :) = temp_storage(end, :);
end

% 3D Surf plot creation
affected_grid = zeros(length(vaccination), length(masks_usage));

for i = 1:length(vaccination)
   for j = 1:length(masks_usage)
       requested_data = find(final_data(:,2)==vaccination(i) & final_data(:,1)== masks_usage(j));
       data_with_affected = final_data(requested_data, :);
       array_sum = sum(data_with_affected);
       affected_grid(i,j) = array_sum(3)/length(requested_data);
   end
        
end
surf(masks_usage, vaccination*100, affected_grid/10);
title(["Affected US population in a COVID-19 outbreak", 
"as a function of mask usage and vaccinated population"]);
xlabel("Masks usage, [%]");
ylabel("Vaccinated population, [%]");
zlabel("Affected population, [Millions of people]");