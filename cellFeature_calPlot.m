clc; clear; 

%% Load .mat file from each experiment set. 
% go to directory  /Users/hailingzong/Dropbox/4 Cell_migration/Imaging

Neg2_R1 = load('cell_data_rps_20161219_R1_Neg2.mat');
MCAK2_R1 = load('cell_data_rps_20161219_R1_MCAK2.mat'); 
Neg2_R2 = load('cell_data_rps_20161219_R2_Neg2.mat');
MCAK2_R2 = load('cell_data_rps_20161219_R2_MCAK2.mat'); 
Neg2_R3 = load('cell_data_rps_20161222_R3_Neg2.mat');
MCAK2_R3 = load('cell_data_rps_20161222_R3_MCAK2.mat'); 

%% Area
% Pool area data of each cell from a single set together
all_data = {Neg2_R1, Neg2_R2, Neg2_R3, MCAK2_R1, MCAK2_R2, MCAK2_R3};
Area = cell(1, length(all_data));
for i = 1:length(all_data);
    for j = 1:length(all_data{i}.cell_data_rps)
        Area{i}= [Area{i}; [all_data{i}.cell_data_rps(j).actin_rps.Area]' *0.18^2];
    end
end;

% Create notched box plots of Areas. Label each box with its corresponding name.
Area_pooled = cell2mat(Area(:));
Area_group_name = [ ones(1, length(cell2mat(Area(1)))), ones(1, length(cell2mat(Area(2))))*2, ...
    ones(1, length(cell2mat(Area(3))))*3, ones(1, length(cell2mat(Area(4))))*4, ...
    ones(1, length(cell2mat(Area(5))))*5, ones(1, length(cell2mat(Area(6))))*6 ]';
figure
boxplot(Area_pooled, Area_group_name, 'Notch','on',...
    'Labels', {'Neg2_R1','Neg2_R2', 'Neg2_R3', 'MCAK2_R1', 'MCAK2_R2', 'MCAK2_R3'});
ylabel ('Area (�m2)'); 
title('Compare Area Data from Different Repeats'); 
print_save_figure(gcf, 'Area', 'Processed');

%% Eccentricity

Eccentricity = cell(1, length(all_data));
for i = 1:length(all_data);
    for j = 1:length(all_data{i}.cell_data_rps)
        Eccentricity{i}= [Eccentricity{i}; [all_data{i}.cell_data_rps(j).actin_rps.Eccentricity]' *0.18^2];
    end
end;

Eccentricity_pooled = cell2mat(Eccentricity(:));
Eccentricity_group_name = [ ones(1, length(cell2mat(Eccentricity(1)))), ones(1, length(cell2mat(Eccentricity(2))))*2, ...
    ones(1, length(cell2mat(Eccentricity(3))))*3, ones(1, length(cell2mat(Eccentricity(4))))*4, ...
    ones(1, length(cell2mat(Eccentricity(5))))*5, ones(1, length(cell2mat(Eccentricity(6))))*6 ]';
figure
boxplot(Eccentricity_pooled, Eccentricity_group_name, 'Notch','on',...
    'Labels', {'Neg2_R1','Neg2_R2', 'Neg2_R3', 'MCAK2_R1', 'MCAK2_R2', 'MCAK2_R3'});
ylabel ('Eccentricity'); 
title('Compare Eccentricity Data from Different Repeats'); 
print_save_figure(gcf, 'Eccentricity', 'Processed');
%%