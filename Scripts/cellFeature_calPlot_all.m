clc; clear;

%% Load .mat file from each experiment set.
% go to directory  /Users/hailingzong/Dropbox/4
% Cell_migration/Imaging/1.Morphology
% 2nd code to run after cellSeg_rps.m. 
% This code calculate descriptive stats and box plot each data set. 
% HZ    Jan, 2017, Bloomington   MATLAB 2016a

Neg2_R1 = load('cell_data_rps_20161219_R1_Neg2.mat');
MCAK2_R1 = load('cell_data_rps_20161219_R1_MCAK2.mat');
Neg2_R2 = load('cell_data_rps_20161219_R2_Neg2.mat');
MCAK2_R2 = load('cell_data_rps_20161219_R2_MCAK2.mat');
Neg2_R3 = load('cell_data_rps_20161222_R3_Neg2.mat');
MCAK2_R3 = load('cell_data_rps_20161222_R3_MCAK2.mat');
Neg2_R4 = load('cell_data_rps_20170225_R4_Neg2.mat');
MCAK2_R4 = load('cell_data_rps_20170225_R4_MCAK2.mat');
MCAK20_R4 = load('cell_data_rps_20170225_R4_MCAK20.mat');

%%
% Pool feature of each cell from a single set together
all_data = {Neg2_R1, Neg2_R2, Neg2_R3, Neg2_R4, MCAK2_R1, MCAK2_R2, MCAK2_R3,...
     MCAK2_R4, MCAK20_R4};
% Parameters of interests
Area = cell(1, length(all_data));
Eccentricity = cell(1, length(all_data));
Perimeter = cell(1, length(all_data));
Solidity = cell(1, length(all_data));
Aspect_Ratio = cell(1, length(all_data));
ConvexArea = cell(1, length(all_data));
Actin_aveIntensity = cell(1, length(all_data));
Actin_intIntensity = cell(1, length(all_data));

for i = 1:length(all_data);
    for j = 1:length(all_data{i}.cell_data_rps)
        Area{i} = [Area{i}; [all_data{i}.cell_data_rps(j).actin_rps.Area]' *0.18^2]; % pixel2->µm2
        Eccentricity{i} = [Eccentricity{i}; [all_data{i}.cell_data_rps(j).actin_rps.Eccentricity]'];
        Perimeter{i} = [Perimeter{i}; [all_data{i}.cell_data_rps(j).actin_rps.Perimeter]' *0.18]; % pixel->µm
        Solidity{i} = [Solidity{i}; [all_data{i}.cell_data_rps(j).actin_rps.Solidity]'];
        Aspect_Ratio{i} = [Aspect_Ratio{i}; [all_data{i}.cell_data_rps(j).actin_rps.MajorAxisLength]'...
            ./[all_data{i}.cell_data_rps(j).actin_rps.MinorAxisLength]'];
        ConvexArea{i} = [ConvexArea{i}; [all_data{i}.cell_data_rps(j).actin_rps.ConvexArea]' *0.18^2]; % pixel2->µm2
        Actin_aveIntensity{i} = [Actin_aveIntensity{i}; [all_data{i}.cell_data_rps(j).actin_rps.AveDen_Red]'];
        Actin_intIntensity{i} = [Actin_intIntensity{i}; [all_data{i}.cell_data_rps(j).actin_rps.IntDen_Red]'];
    end
end;

%% Create notched box plots of parameters.
Area_pooled = cell2mat(Area(:));
Eccentricity_pooled = cell2mat(Eccentricity(:));
Perimeter_pooled = cell2mat(Perimeter(:));
Solidity_pooled = cell2mat(Solidity(:));
Aspect_Ratio_pooled = cell2mat(Aspect_Ratio(:));
ConvexArea_pooled = cell2mat(Aspect_Ratio(:));
Actin_aveIntensity_pooled = cell2mat(Actin_aveIntensity(:));
Actin_intIntensity_pooled = cell2mat(Actin_intIntensity(:));

Group_name = [ ones(1, length(cell2mat(Area(1)))), ones(1, length(cell2mat(Area(2))))*2, ...
    ones(1, length(cell2mat(Area(3))))*3, ones(1, length(cell2mat(Area(4))))*4, ...
    ones(1, length(cell2mat(Area(5))))*5, ones(1, length(cell2mat(Area(6))))*6, ...
    ones(1, length(cell2mat(Area(7))))*7, ones(1, length(cell2mat(Area(8))))*8, ...
    ones(1, length(cell2mat(Area(9))))*9]';

figure(1)
set_print_page(gcf, 0);
subplot (2, 2, 1) % Area
boxplot(Area_pooled, Group_name, 'Notch','on');
xticklabel_rotate((1:9),45,{{'Neg2_1'},{'Neg2_2'}, {'Neg2_3'}, {'Neg2_4'},...
    {'MCAK2_1'}, {'MCAK2_2'}, {'MCAK2_3'}, {'MCAK2_4'}, {'MCAK20'}}, 'Interpreter', 'none');
title ('Area (µm^{2})');

subplot (2, 2, 2) % Peremeter
boxplot(Perimeter_pooled, Group_name, 'Notch','on');
xticklabel_rotate((1:9),45,{{'Neg2_1'},{'Neg2_2'}, {'Neg2_3'}, {'Neg2_4'},...
    {'MCAK2_1'}, {'MCAK2_2'}, {'MCAK2_3'}, {'MCAK2_4'}, {'MCAK20'}}, 'Interpreter', 'none');
title ('Perimeter');

subplot (2, 2, 3) % Eccentricity
boxplot(Eccentricity_pooled, Group_name, 'Notch','on');
xticklabel_rotate((1:9),45,{{'Neg2_1'},{'Neg2_2'}, {'Neg2_3'}, {'Neg2_4'},...
    {'MCAK2_1'}, {'MCAK2_2'}, {'MCAK2_3'}, {'MCAK2_4'}, {'MCAK20'}}, 'Interpreter', 'none');
title ('Eccentricity');

subplot (2, 2, 4) % Solidity
boxplot(Solidity_pooled, Group_name, 'Notch','on');
xticklabel_rotate((1:9),45,{{'Neg2_1'},{'Neg2_2'}, {'Neg2_3'}, {'Neg2_4'},...
    {'MCAK2_1'}, {'MCAK2_2'}, {'MCAK2_3'}, {'MCAK2_4'}, {'MCAK20'}}, 'Interpreter', 'none');
ylim([0.4 1]);
title ('Solidity');
print_save_figure(gcf, 'Fig1.ALL_Area_perimeter_eccentricity_solidity', 'Processed');
%%
figure(2)
set_print_page(gcf, 0);
subplot (2, 2, 1) % Aspect_Ratio
boxplot(Aspect_Ratio_pooled, Group_name, 'notch', 'on');
xticklabel_rotate((1:9),45,{{'Neg2_1'},{'Neg2_2'}, {'Neg2_3'}, {'Neg2_4'},...
    {'MCAK2_1'}, {'MCAK2_2'}, {'MCAK2_3'}, {'MCAK2_4'}, {'MCAK20'}}, 'Interpreter', 'none');
title ('Aspect Ratio');

subplot (2, 2, 2) % Convex Area
boxplot(ConvexArea_pooled, Group_name, 'notch', 'on');
xticklabel_rotate((1:9),45,{{'Neg2_1'},{'Neg2_2'}, {'Neg2_3'}, {'Neg2_4'},...
    {'MCAK2_1'}, {'MCAK2_2'}, {'MCAK2_3'}, {'MCAK2_4'}, {'MCAK20'}}, 'Interpreter', 'none');
title ('Convex Area');

subplot (2, 2, 3) % Actin_aveIntensity
boxplot(Actin_aveIntensity_pooled, Group_name, 'notch', 'on');
xticklabel_rotate((1:9),45,{{'Neg2_1'},{'Neg2_2'}, {'Neg2_3'}, {'Neg2_4'},...
    {'MCAK2_1'}, {'MCAK2_2'}, {'MCAK2_3'}, {'MCAK2_4'}, {'MCAK20'}}, 'Interpreter', 'none');
title ('Average actin intensity (A.U.)');

subplot (2, 2, 4) % Actin_intIntensity
boxplot(Actin_intIntensity_pooled, Group_name, 'notch', 'on');
xticklabel_rotate((1:9),45,{{'Neg2_1'},{'Neg2_2'}, {'Neg2_3'}, {'Neg2_4'},...
    {'MCAK2_1'}, {'MCAK2_2'}, {'MCAK2_3'}, {'MCAK2_4'}, {'MCAK20'}}, 'Interpreter', 'none');
title ('Integrated actin intensity (A.U.)');

print_save_figure(gcf, 'Fig2.ALL_AspectRatio_ConvexArea_ActinIntensity', 'Processed');

%% Descriptive statistics
Area = descriptive_stats (Area);
Eccentricity = descriptive_stats (Eccentricity);
Perimeter = descriptive_stats (Perimeter);
Solidity = descriptive_stats (Solidity);
Aspect_Ratio= descriptive_stats (Aspect_Ratio);
ConvexArea= descriptive_stats (ConvexArea);
Actin_aveIntensity= descriptive_stats (Actin_aveIntensity);
Actin_intIntensity= descriptive_stats (Actin_intIntensity);

%% Save stats
save('cellFeature_stats', 'Area', 'Eccentricity', 'Perimeter', 'Solidity', ...
    'Aspect_Ratio', 'ConvexArea', 'Actin_aveIntensity', 'Actin_intIntensity');
close all;
