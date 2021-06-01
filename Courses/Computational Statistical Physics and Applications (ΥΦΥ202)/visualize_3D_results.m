clear; clc; close all; 

% [N95 = 2, medical = 3, homemade = 4]

masks = 2;

if masks == 2
    raw_input = readmatrix("iterative_n95_vaccinated.csv");
    masks_column = 2;
    raw_input = sortrows(raw_input);
elseif masks == 3
    raw_input = readmatrix("iterative_n95_vaccinated.csv");
    masks_column = 3;
    raw_input = sortrows(raw_input);
elseif masks == 4
    raw_input = readmatrix("iterative_n95_vaccinated.csv");
    masks_column = 4;
    raw_input = sortrows(raw_input);
end

% Define Column Rows

run_column = 1;
percent_vaccinated_column = 5;
step_column = 6;
max_affected_column = 7;

% Read data
main_data = raw_input(3:end-1,...
    [masks_column percent_vaccinated_column max_affected_column step_column run_column]);

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

vaccination_affected = affected_grid(:,1)/10;
masks_affected = (affected_grid(1, :)).';

fitobject = fit(vaccination, vaccination_affected, 'poly1');

figure;
hold on;
plot(fitobject, vaccination, vaccination_affected)
grid on;
xlabel('Vaccinated population, [%]');
ylabel('Affected population, [Millions]');

fitobject = fit(masks_usage, masks_affected, 'poly1');

figure;
plot(fitobject, masks_usage, masks_affected, '.');
xlabel('Masks Usage, [%]');
ylabel('Affected population, [Millions]');
grid on;

