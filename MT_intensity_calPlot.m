clc; clear;

%% Load .mat file from each experiment set.
% go to directory  /Users/hailingzong/Dropbox/4
% Cell_migration/Imaging/1.Morphology
% 2nd code to run after cellSeg_rps.m. 
% This code calculate descriptive stats and box plot each data set. 
% HZ    Jan, 2017, Bloomington   MATLAB 2016a

Neg2 = load('MT_rps_20170225_R4_Neg2.mat');
MCAK2 = load('MT_rps_20170225_R4_MCAK2.mat');
MCAK20 = load('MT_rps_20170225_R4_MCAK20.mat');

%%
% Pool feature of each cell from a single set together
all_data = {Neg2, MCAK2, MCAK20};
% Parameters of interests
MT_aveIntensity = cell(1, length(all_data));
MT_intIntensity = cell(1, length(all_data));

for i = 1:length(all_data);
    for j = 1:length(all_data{i}.cell_data_rps)
        MT_aveIntensity{i} = [MT_aveIntensity{i}; ...
            [all_data{i}.cell_data_rps(j).MT_rps.AveDen_FITC]'];
        MT_intIntensity{i} = [MT_intIntensity{i}; ...
            [all_data{i}.cell_data_rps(j).MT_rps.IntDen_FITC]'];
    end
end;

%% Create notched box plots of parameters.

MT_aveIntensity_pooled = cell2mat(MT_aveIntensity(:));
MT_intIntensity_pooled = cell2mat(MT_intIntensity(:));

Group_name = [ ones(1, length(cell2mat(MT_aveIntensity(1)))), ...
    ones(1, length(cell2mat(MT_aveIntensity(2))))*2, ...
    ones(1, length(cell2mat(MT_aveIntensity(3))))*3 ]';

figure(1)
set_print_page(gcf, 0);
boxplot(MT_aveIntensity_pooled, Group_name, 'notch', 'on');
xticklabel_rotate((1:3),45,{{'Neg2'},{'MCAK2'}, {'MCAK20'}}, 'Interpreter', 'none')
title ('Average MT intensity (A.U.)');
print_save_figure(gcf, 'Fig3.Ave_MT_Intensity', 'Processed');

figure(2)
set_print_page(gcf, 0);
boxplot(MT_intIntensity_pooled, Group_name, 'notch', 'on');
xticklabel_rotate((1:3),45,{{'Neg2'},{'MCAK2'}, {'MCAK20'}}, 'Interpreter', 'none')
title ('Integrated MT intensity (A.U.)');

print_save_figure(gcf, 'Fig4.Integrated_MT_Intensity', 'Processed');

%% Descriptive statistics
MT_aveIntensity= descriptive_stats (MT_aveIntensity);
MT_intIntensity= descriptive_stats (MT_intIntensity);

%% Save stats
save('MT_intensity_stats', 'MT_aveIntensity', 'MT_intIntensity');
close all;
