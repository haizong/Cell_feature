clc; clear;
fontsize = 10; 
%% Load .mat file from each experiment set.
% go to directory  /Users/hailingzong/Dropbox/7 Thesis/4_Chapter_4/Fig4.4_Rac1_OX

% 2nd code to run after cellSeg_rps_Rac.m. 
% This code calculate descriptive stats and box plot each data set. 
% HZ    Oct, 2017, Oakland   MATLAB 2016a

M2_GFP_R1 = load('cell_data_rps_20170918_Set1_M2_GFP.mat');
M2_GFP_Rac1_R1 = load('cell_data_rps_20170918_Set1_M2_GFP-Rac1.mat');
Neg2_GFP_R1= load('cell_data_rps_20170918_Set1_Neg2_GFP.mat');
Neg2_GFP_Rac1_R1 = load('cell_data_rps_20170918_Set1_Neg2_GFP-Rac1.mat');

M2_GFP_R2 = load('cell_data_rps_20170918_Set2_MCAK2_GFP.mat');
M2_GFP_Rac1_R2 = load('cell_data_rps_20170918_Set2_MCAK2_Rac1-GFP.mat');
Neg2_GFP_R2= load('cell_data_rps_20170918_Set2_Neg2_GFP.mat');
Neg2_GFP_Rac1_R2 = load('cell_data_rps_20170918_Set2_Neg2_Rac1-GFP.mat');

M2_GFP_R3 = load('cell_data_rps_20170919_Set3_MCAK2_GFP.mat');
M2_GFP_Rac1_R3 = load('cell_data_rps_20170919_Set3_MCAK2_Rac1-GFP.mat');
Neg2_GFP_R3= load('cell_data_rps_20170919_Set3_Neg2_GFP.mat');
Neg2_GFP_Rac1_R3 = load('cell_data_rps_20170919_Set3_Neg2_Rac1-GFP.mat');

M2_GFP_R4 = load('cell_data_rps_20170919_Set4_MCAK2_GFP.mat');
M2_GFP_Rac1_R4 = load('cell_data_rps_20170919_Set4_MCAK2_Rac1-GFP.mat');
Neg2_GFP_R4= load('cell_data_rps_20170919_Set4_Neg2_GFP.mat');
Neg2_GFP_Rac1_R4 = load('cell_data_rps_20170919_Set4_Neg2_Rac1-GFP.mat');

M2_GFP_R5 = load('cell_data_rps_20170919_Set5_MCAK2_GFP.mat');
M2_GFP_Rac1_R5 = load('cell_data_rps_20170919_Set5_MCAK2_Rac1-GFP.mat');
Neg2_GFP_R5= load('cell_data_rps_20170919_Set5_Neg2_GFP.mat');
Neg2_GFP_Rac1_R5 = load('cell_data_rps_20170919_Set5_Neg2_Rac1-GFP.mat');

%%
% Pool feature of each cell from a single set together
all_data = {Neg2_GFP_R1, M2_GFP_R1, Neg2_GFP_Rac1_R1, M2_GFP_Rac1_R1,...
    Neg2_GFP_R2, M2_GFP_R2, Neg2_GFP_Rac1_R2, M2_GFP_Rac1_R2,...
    Neg2_GFP_R3, M2_GFP_R3, Neg2_GFP_Rac1_R3, M2_GFP_Rac1_R3,...
    Neg2_GFP_R4, M2_GFP_R4, Neg2_GFP_Rac1_R4, M2_GFP_Rac1_R4...
    Neg2_GFP_R5, M2_GFP_R5, Neg2_GFP_Rac1_R5, M2_GFP_Rac1_R5};
% Parameters of interests
Area = cell(1, length(all_data));
Eccentricity = cell(1, length(all_data));
Perimeter = cell(1, length(all_data));
Solidity = cell(1, length(all_data));
Aspect_Ratio = cell(1, length(all_data));
ConvexArea = cell(1, length(all_data));
GFP_aveIntensity = cell(1, length(all_data));
GFP_intIntensity = cell(1, length(all_data));

for i = 1:length(all_data);
    for j = 1:length(all_data{i}.cell_data_rps)
        if isempty(all_data{i}.cell_data_rps(j).GFP_rps) == 0 
        Area{i} = [Area{i}; [all_data{i}.cell_data_rps(j).GFP_rps.Area]' *0.18^2]; % pixel2->µm2
        Eccentricity{i} = [Eccentricity{i}; [all_data{i}.cell_data_rps(j).GFP_rps.Eccentricity]'];
        Perimeter{i} = [Perimeter{i}; [all_data{i}.cell_data_rps(j).GFP_rps.Perimeter]' *0.18]; % pixel->µm
        Solidity{i} = [Solidity{i}; [all_data{i}.cell_data_rps(j).GFP_rps.Solidity]'];
        Aspect_Ratio{i} = [Aspect_Ratio{i}; [all_data{i}.cell_data_rps(j).GFP_rps.MajorAxisLength]'...
            ./[all_data{i}.cell_data_rps(j).GFP_rps.MinorAxisLength]'];
        ConvexArea{i} = [ConvexArea{i}; [all_data{i}.cell_data_rps(j).GFP_rps.ConvexArea]' *0.18^2]; % pixel2->µm2
        GFP_aveIntensity{i} = [GFP_aveIntensity{i}; [all_data{i}.cell_data_rps(j).GFP_rps.AveDen_GFP]'];
        GFP_intIntensity{i} = [GFP_intIntensity{i}; [all_data{i}.cell_data_rps(j).GFP_rps.IntDen_GFP]'];
        end     
    end
end;

%% Create notched box plots of parameters.
Area_pooled = cell2mat(Area(:));
Eccentricity_pooled = cell2mat(Eccentricity(:));
Perimeter_pooled = cell2mat(Perimeter(:));
Solidity_pooled = cell2mat(Solidity(:));
Aspect_Ratio_pooled = cell2mat(Aspect_Ratio(:));
ConvexArea_pooled = cell2mat(Aspect_Ratio(:));
Actin_aveIntensity_pooled = cell2mat(GFP_aveIntensity(:));
Actin_intIntensity_pooled = cell2mat(GFP_intIntensity(:));

Group_name = [ ones(1, length(cell2mat(Area(1)))), ones(1, length(cell2mat(Area(2))))*2, ...
    ones(1, length(cell2mat(Area(3))))*3, ones(1, length(cell2mat(Area(4))))*4, ...
    ones(1, length(cell2mat(Area(5))))*5, ones(1, length(cell2mat(Area(6))))*6, ...
    ones(1, length(cell2mat(Area(7))))*7, ones(1, length(cell2mat(Area(8))))*8, ...
    ones(1, length(cell2mat(Area(9))))*9, ones(1, length(cell2mat(Area(10))))*10,...
    ones(1, length(cell2mat(Area(11))))*11, ones(1, length(cell2mat(Area(12))))*12,...
    ones(1, length(cell2mat(Area(13))))*13, ones(1, length(cell2mat(Area(14))))*14,...
    ones(1, length(cell2mat(Area(15))))*15, ones(1, length(cell2mat(Area(16))))*16,...
    ones(1, length(cell2mat(Area(17))))*17, ones(1, length(cell2mat(Area(18))))*18,...
    ones(1, length(cell2mat(Area(19))))*19, ones(1, length(cell2mat(Area(20))))*20]';

%% Figure 1 Area_perimeter_eccentricity_solidity

figure(1)
set_print_page(gcf, 0);
subplot (2, 2, 1) % Area
boxplot(Area_pooled, Group_name, 'Notch','on', 'Symbol', 'k.', 'OutlierSize', 4);
xticklabel_rotate((1:20),45,{{'Neg2_GFP_R1'},{'M2_GFP_R1'}, {'Neg2_GFP_Rac1_R1'}, {'M2_GFP_Rac1_R1'},...
    {'Neg2_GFP_R2'}, {'M2_GFP_R2'}, {'Neg2_GFP_Rac1_R2'}, {'M2_GFP_Rac1_R2'}, ...
    {'Neg2_GFP_R3'}, {'M2_GFP_R3'}, {'Neg2_GFP_Rac1_R3'}, {'M2_GFP_Rac1_R3'}, ...
    {'Neg2_GFP_R4'}, {'M2_GFP_R4'}, {'Neg2_GFP_Rac1_R4'}, {'M2_GFP_Rac1_R4'}, ...
    {'Neg2_GFP_R5'}, {'M2_GFP_R5'}, {'Neg2_GFP_Rac1_R5'}, {'M2_GFP_Rac1_R5'}},'Interpreter', 'none');

title ('Area (µm^{2})');

subplot (2, 2, 2) % Peremeter
boxplot(Perimeter_pooled, Group_name, 'Notch','on', 'Symbol', 'k.', 'OutlierSize', 4);
xticklabel_rotate((1:20),45,{{'Neg2_GFP_R1'},{'M2_GFP_R1'}, {'Neg2_GFP_Rac1_R1'}, {'M2_GFP_Rac1_R1'},...
    {'Neg2_GFP_R2'}, {'M2_GFP_R2'}, {'Neg2_GFP_Rac1_R2'}, {'M2_GFP_Rac1_R2'}, ...
    {'Neg2_GFP_R3'}, {'M2_GFP_R3'}, {'Neg2_GFP_Rac1_R3'}, {'M2_GFP_Rac1_R3'}, ...
    {'Neg2_GFP_R4'}, {'M2_GFP_R4'}, {'Neg2_GFP_Rac1_R4'}, {'M2_GFP_Rac1_R4'}, ...
    {'Neg2_GFP_R5'}, {'M2_GFP_R5'}, {'Neg2_GFP_Rac1_R5'}, {'M2_GFP_Rac1_R5'}},'Interpreter', 'none');
title ('Perimeter');

subplot (2, 2, 3) % Eccentricity
boxplot(Eccentricity_pooled, Group_name, 'Notch','on', 'Symbol', 'k.', 'OutlierSize', 4);
xticklabel_rotate((1:20),45,{{'Neg2_GFP_R1'},{'M2_GFP_R1'}, {'Neg2_GFP_Rac1_R1'}, {'M2_GFP_Rac1_R1'},...
    {'Neg2_GFP_R2'}, {'M2_GFP_R2'}, {'Neg2_GFP_Rac1_R2'}, {'M2_GFP_Rac1_R2'}, ...
    {'Neg2_GFP_R3'}, {'M2_GFP_R3'}, {'Neg2_GFP_Rac1_R3'}, {'M2_GFP_Rac1_R3'}, ...
    {'Neg2_GFP_R4'}, {'M2_GFP_R4'}, {'Neg2_GFP_Rac1_R4'}, {'M2_GFP_Rac1_R4'}, ...
    {'Neg2_GFP_R5'}, {'M2_GFP_R5'}, {'Neg2_GFP_Rac1_R5'}, {'M2_GFP_Rac1_R5'}},'Interpreter', 'none');
title ('Eccentricity');

subplot (2, 2, 4) % Solidity
boxplot(Solidity_pooled, Group_name, 'Notch','on', 'Symbol', 'k.', 'OutlierSize', 4);
xticklabel_rotate((1:20),45,{{'Neg2_GFP_R1'},{'M2_GFP_R1'}, {'Neg2_GFP_Rac1_R1'}, {'M2_GFP_Rac1_R1'},...
    {'Neg2_GFP_R2'}, {'M2_GFP_R2'}, {'Neg2_GFP_Rac1_R2'}, {'M2_GFP_Rac1_R2'}, ...
    {'Neg2_GFP_R3'}, {'M2_GFP_R3'}, {'Neg2_GFP_Rac1_R3'}, {'M2_GFP_Rac1_R3'}, ...
    {'Neg2_GFP_R4'}, {'M2_GFP_R4'}, {'Neg2_GFP_Rac1_R4'}, {'M2_GFP_Rac1_R4'}, ...
    {'Neg2_GFP_R5'}, {'M2_GFP_R5'}, {'Neg2_GFP_Rac1_R5'}, {'M2_GFP_Rac1_R5'}},'Interpreter', 'none');
ylim([0.4 1]);
title ('Solidity');
print_save_figure(gcf, 'Fig1.Area_perimeter_eccentricity_solidity', 'Processed');

%% Figure 2 AspectRatio_ConvexArea_GFPIntensity

figure(2)
set_print_page(gcf, 0);
subplot (2, 2, 1) % Aspect_Ratio
boxplot(Aspect_Ratio_pooled, Group_name, 'notch', 'on', 'Symbol', 'k.', 'OutlierSize', 4);
xticklabel_rotate((1:20),45,{{'Neg2_GFP_R1'},{'M2_GFP_R1'}, {'Neg2_GFP_Rac1_R1'}, {'M2_GFP_Rac1_R1'},...
    {'Neg2_GFP_R2'}, {'M2_GFP_R2'}, {'Neg2_GFP_Rac1_R2'}, {'M2_GFP_Rac1_R2'}, ...
    {'Neg2_GFP_R3'}, {'M2_GFP_R3'}, {'Neg2_GFP_Rac1_R3'}, {'M2_GFP_Rac1_R3'}, ...
    {'Neg2_GFP_R4'}, {'M2_GFP_R4'}, {'Neg2_GFP_Rac1_R4'}, {'M2_GFP_Rac1_R4'}, ...
    {'Neg2_GFP_R5'}, {'M2_GFP_R5'}, {'Neg2_GFP_Rac1_R5'}, {'M2_GFP_Rac1_R5'}},'Interpreter', 'none');
title ('Aspect Ratio');

subplot (2, 2, 2) % Convex Area
boxplot(ConvexArea_pooled, Group_name, 'notch', 'on', 'Symbol', 'k.', 'OutlierSize', 4);
xticklabel_rotate((1:20),45,{{'Neg2_GFP_R1'},{'M2_GFP_R1'}, {'Neg2_GFP_Rac1_R1'}, {'M2_GFP_Rac1_R1'},...
    {'Neg2_GFP_R2'}, {'M2_GFP_R2'}, {'Neg2_GFP_Rac1_R2'}, {'M2_GFP_Rac1_R2'}, ...
    {'Neg2_GFP_R3'}, {'M2_GFP_R3'}, {'Neg2_GFP_Rac1_R3'}, {'M2_GFP_Rac1_R3'}, ...
    {'Neg2_GFP_R4'}, {'M2_GFP_R4'}, {'Neg2_GFP_Rac1_R4'}, {'M2_GFP_Rac1_R4'}, ...
    {'Neg2_GFP_R5'}, {'M2_GFP_R5'}, {'Neg2_GFP_Rac1_R5'}, {'M2_GFP_Rac1_R5'}},'Interpreter', 'none');title ('Convex Area');

subplot (2, 2, 3) % Actin_aveIntensity
boxplot(Actin_aveIntensity_pooled, Group_name, 'notch', 'on', 'Symbol', 'k.', 'OutlierSize', 4);
xticklabel_rotate((1:20),45,{{'Neg2_GFP_R1'},{'M2_GFP_R1'}, {'Neg2_GFP_Rac1_R1'}, {'M2_GFP_Rac1_R1'},...
    {'Neg2_GFP_R2'}, {'M2_GFP_R2'}, {'Neg2_GFP_Rac1_R2'}, {'M2_GFP_Rac1_R2'}, ...
    {'Neg2_GFP_R3'}, {'M2_GFP_R3'}, {'Neg2_GFP_Rac1_R3'}, {'M2_GFP_Rac1_R3'}, ...
    {'Neg2_GFP_R4'}, {'M2_GFP_R4'}, {'Neg2_GFP_Rac1_R4'}, {'M2_GFP_Rac1_R4'}, ...
    {'Neg2_GFP_R5'}, {'M2_GFP_R5'}, {'Neg2_GFP_Rac1_R5'}, {'M2_GFP_Rac1_R5'}},'Interpreter', 'none');
title ('Average GFP intensity (A.U.)');

subplot (2, 2, 4) % Actin_intIntensity
boxplot(Actin_intIntensity_pooled, Group_name, 'notch', 'on', 'Symbol', 'k.', 'OutlierSize', 4);
xticklabel_rotate((1:20),45,{{'Neg2_GFP_R1'},{'M2_GFP_R1'}, {'Neg2_GFP_Rac1_R1'}, {'M2_GFP_Rac1_R1'},...
    {'Neg2_GFP_R2'}, {'M2_GFP_R2'}, {'Neg2_GFP_Rac1_R2'}, {'M2_GFP_Rac1_R2'}, ...
    {'Neg2_GFP_R3'}, {'M2_GFP_R3'}, {'Neg2_GFP_Rac1_R3'}, {'M2_GFP_Rac1_R3'}, ...
    {'Neg2_GFP_R4'}, {'M2_GFP_R4'}, {'Neg2_GFP_Rac1_R4'}, {'M2_GFP_Rac1_R4'}, ...
    {'Neg2_GFP_R5'}, {'M2_GFP_R5'}, {'Neg2_GFP_Rac1_R5'}, {'M2_GFP_Rac1_R5'}},'Interpreter', 'none');
title ('Integrated GFP intensity (A.U.)');

print_save_figure(gcf, 'Fig2.AspectRatio_ConvexArea_GFPIntensity', 'Processed');

%% Descriptive statistics
Area = descriptive_stats (Area);
Eccentricity = descriptive_stats (Eccentricity);
Perimeter = descriptive_stats (Perimeter);
Solidity = descriptive_stats (Solidity);
Aspect_Ratio= descriptive_stats (Aspect_Ratio);
ConvexArea= descriptive_stats (ConvexArea);
GFP_aveIntensity= descriptive_stats (GFP_aveIntensity);
GFP_intIntensity= descriptive_stats (GFP_intIntensity);

%% Save stats
save('cellFeature_stats', 'Area', 'Eccentricity', 'Perimeter', 'Solidity', ...
    'Aspect_Ratio', 'ConvexArea', 'GFP_aveIntensity', 'GFP_intIntensity');
close all;
