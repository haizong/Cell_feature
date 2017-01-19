clc; clear;
fontsize = 12; 
%% Load .mat file from each experiment set.
% go to directory  
% 2nd code to run after FA_identify.m. 
% This code calculate descriptive stats and box plot each data set. 
% set dir /Users/hailingzong/Dropbox/4 Cell_migration/Imaging/2.Focal_adhesion
% HZ    Jan, 2017, Bloomington   MATLAB 2016a

Neg2_R1 = load('FA_rps_20170109_R1Neg2.mat');
MCAK2_R1 = load('FA_rps_20170109_R1MCAK2.mat');
Neg2_R2 = load('FA_rps_20170109_R2Neg2.mat');
MCAK2_R2 = load('FA_rps_20170109_R2MCAK2.mat');
Neg2_R3 = load('FA_rps_20170109_R3Neg2.mat');
MCAK2_R3 = load('FA_rps_20170109_R3MCAK2.mat');

%%
% Pool feature of each cell from a single set together
all_data = {Neg2_R1, Neg2_R2, Neg2_R3, MCAK2_R1, MCAK2_R2, MCAK2_R3};

% Parameters of interests
Number = cell(1, length(all_data));
Area = cell(1, length(all_data));
Total_Area = cell(1, length(all_data));

for i = 1:length(all_data);
    for j = 1:length(all_data{i}.cell_data_rps)
        for k = 1:length(all_data{i}.cell_data_rps(j).FA)
            if  ~isempty(all_data{i}.cell_data_rps(j).FA)
                Area{i} = [Area{i}; [all_data{i}.cell_data_rps(j).FA(k).rps.Area]' *0.108^2]; % pixel2->µm2
                Number{i} = [Number{i}; [all_data{i}.cell_data_rps(j).FA(k).num]'];
                Total_Area{i} = [Total_Area{i}; sum([all_data{i}.cell_data_rps(j).FA(k).rps.Area]*0.108^2)'];
            else
                continue
            end
        end
    end
end;

%% Create notched box plots of parameters.
Area_pooled = cell2mat(Area(:));
Number_pooled = cell2mat(Number(:));
Total_Area_pooled = cell2mat(Total_Area(:));

Group_name = [ ones(1, length(cell2mat(Area(1)))), ones(1, length(cell2mat(Area(2))))*2, ...
    ones(1, length(cell2mat(Area(3))))*3, ones(1, length(cell2mat(Area(4))))*4, ...
    ones(1, length(cell2mat(Area(5))))*5, ones(1, length(cell2mat(Area(6))))*6 ]';

Group_name_Number = [ ones(1, length(cell2mat(Number(1)))), ones(1, length(cell2mat(Number(2))))*2, ...
    ones(1, length(cell2mat(Number(3))))*3, ones(1, length(cell2mat(Number(4))))*4, ...
    ones(1, length(cell2mat(Number(5))))*5, ones(1, length(cell2mat(Number(6))))*6 ]';
%%
figure()
set_print_page(gcf, 0);
subplot (2, 2, 1) % Area
boxplot(Area_pooled, Group_name);
h=findobj(gca,'tag','Outliers');
delete(h);
ylim([0, 5]);
xticklabel_rotate((1:6),45,{{'Neg2_1'},{'Neg2_2'}, {'Neg2_3'},...
    {'MCAK2_1'}, {'MCAK2_2'}, {'MCAK2_3'}}, 'Interpreter', 'none')
ylabel ('Area (µm^{2})', 'fontweight','bold', 'fontsize', fontsize);

subplot (2, 2, 2) % Number
boxplot(Number_pooled, Group_name_Number, 'Notch','on');
xticklabel_rotate((1:6),45,{{'Neg2_1'},{'Neg2_2'}, {'Neg2_3'},...
    {'MCAK2_1'}, {'MCAK2_2'}, {'MCAK2_3'}}, 'Interpreter', 'none')
ylabel ('FA Number/Cell', 'fontweight','bold', 'fontsize', fontsize);

subplot (2, 2, 3) % Total_Area
boxplot(Total_Area_pooled, Group_name_Number, 'notch', 'on');
xticklabel_rotate((1:6),45,{{'Neg2_1'},{'Neg2_2'}, {'Neg2_3'},...
    {'MCAK2_1'}, {'MCAK2_2'}, {'MCAK2_3'}}, 'Interpreter', 'none')
ylabel ('Total area (µm^{2})/Cell', 'fontweight','bold', 'fontsize', fontsize);

print_save_figure(gcf, 'Fig1.FA_Area_Num_totalArea', 'Processed');

%% Descriptive statistics
Area = descriptive_stats (Area);
Number = descriptive_stats (Number);
Total_Area = descriptive_stats (Total_Area);

%% Save stats
save('FA_Feature_stats', 'Area', 'Number', 'Total_Area');
close all;

