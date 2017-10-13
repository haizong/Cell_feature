%% Load .mat file from each experiment set.
% 2nd code to run after FA_identify.m.
%
% This code calculate descriptive stats and box plot of both FA (area, num, int)
% and cell properties (area, eccentricity, solidity) of individual data set.
% set dir /Users/hailingzong/Dropbox/4 Cell_migration/Imaging/2.Focal_adhesion
% HZ    Jan, 2017, Bloomington   MATLAB 2016a

%%
clc; clear;
fontsize = 12;

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
% Save all numbers in a 1x6 cell array. Column 1-3 is Neg2 and column 4-6
% is MCAK2. 
Area = cell(1, length(all_data));
Number = cell(1, length(all_data));
Total_Area = cell(1, length(all_data));

AveDen = cell(1, length(all_data));
IntDen = cell(1, length(all_data));
IntDen_per_cell = cell(1, length(all_data));

Cell_Area = cell(1, length(all_data));
Cell_Eccentricity = cell(1, length(all_data));
Cell_Solidity = cell(1, length(all_data));

%%

for i = 1:length(all_data);
    for j = 1:length(all_data{i}.cell_data_rps)
        for m = 1:length(all_data{i}.cell_data_rps(j).actin_rps)
            for k = 1:length(all_data{i}.cell_data_rps(j).FA)
                if  ~isempty(all_data{i}.cell_data_rps(j).actin_rps) && ~isempty(all_data{i}.cell_data_rps(j).FA)
                    Area{i} = [Area{i}; [all_data{i}.cell_data_rps(j).FA(k).rps.Area]' *0.108^2]; % pixel2->µm2
                    Number{i} = [Number{i}; [all_data{i}.cell_data_rps(j).FA(k).num]'];
                    Total_Area{i} = [Total_Area{i}; sum([all_data{i}.cell_data_rps(j).FA(k).rps.Area]*0.108^2)'];
                    
                    AveDen{i} = [AveDen{i}; [all_data{i}.cell_data_rps(j).FA(k).rps.AveDen]'];
                    IntDen{i} = [IntDen{i}; [all_data{i}.cell_data_rps(j).FA(k).rps.IntDen]'];
                    IntDen_per_cell{i} = [IntDen_per_cell{i}; [all_data{i}.cell_data_rps(j).FA(k).IntDen_cell]'];
                    
                    Cell_Area{i} = [Cell_Area{i}; [all_data{i}.cell_data_rps(j).actin_rps(m).Area]];
                    Cell_Eccentricity{i} = [Cell_Eccentricity{i}; [all_data{i}.cell_data_rps(j).actin_rps(m).Eccentricity]];
                    Cell_Solidity{i} = [Cell_Solidity{i}; [all_data{i}.cell_data_rps(j).actin_rps(m).Solidity]];
                    
                else
                    continue
                end
            end
        end
    end
end;

%% Create notched box plots of parameters.
Area_pooled = cell2mat(Area(:));
Number_pooled = cell2mat(Number(:));
Total_Area_pooled = cell2mat(Total_Area(:));

AveDen_pooled = cell2mat(AveDen(:));
IntDen_pooled = cell2mat(IntDen(:));
IntDen_per_cell_pooled = cell2mat(IntDen_per_cell(:));

Cell_Area_pooled = cell2mat(Cell_Area(:));
Cell_Eccentricity_pooled = cell2mat(Cell_Eccentricity(:));
Cell_Solidity_pooled = cell2mat(Cell_Solidity(:));

Group_name = [ ones(1, length(cell2mat(Area(1)))), ones(1, length(cell2mat(Area(2))))*2, ...
    ones(1, length(cell2mat(Area(3))))*3, ones(1, length(cell2mat(Area(4))))*4, ...
    ones(1, length(cell2mat(Area(5))))*5, ones(1, length(cell2mat(Area(6))))*6 ]';

Group_name_Number = [ ones(1, length(cell2mat(Number(1)))), ones(1, length(cell2mat(Number(2))))*2, ...
    ones(1, length(cell2mat(Number(3))))*3, ones(1, length(cell2mat(Number(4))))*4, ...
    ones(1, length(cell2mat(Number(5))))*5, ones(1, length(cell2mat(Number(6))))*6 ]';
%%
figure()
set_print_page(gcf, 0);
subplot (3, 3, 1) % Area
boxplot(Area_pooled, Group_name);
h=findobj(gca,'tag','Outliers');
delete(h);
ylim([0, 5]);
xticklabel_rotate((1:6),45,{{'Neg2_1'},{'Neg2_2'}, {'Neg2_3'},...
    {'MCAK2_1'}, {'MCAK2_2'}, {'MCAK2_3'}}, 'Interpreter', 'none')
ylabel ('FA Area (µm^{2})', 'fontweight','bold', 'fontsize', fontsize);

subplot (3, 3, 2) % Number
boxplot(Number_pooled, Group_name_Number, 'Notch','on');
h=findobj(gca,'tag','Outliers');
delete(h);
xticklabel_rotate((1:6),45,{{'Neg2_1'},{'Neg2_2'}, {'Neg2_3'},...
    {'MCAK2_1'}, {'MCAK2_2'}, {'MCAK2_3'}}, 'Interpreter', 'none')
ylabel ('FA Number/Cell', 'fontweight','bold', 'fontsize', fontsize);

subplot (3, 3, 3) % Total_Area
boxplot(Total_Area_pooled, Group_name_Number, 'notch', 'on');
xticklabel_rotate((1:6),45,{{'Neg2_1'},{'Neg2_2'}, {'Neg2_3'},...
    {'MCAK2_1'}, {'MCAK2_2'}, {'MCAK2_3'}}, 'Interpreter', 'none')
ylabel ('Total area (µm^{2})/Cell', 'fontweight','bold', 'fontsize', fontsize);

subplot (3, 3, 4) % AveDen
boxplot(AveDen_pooled, Group_name, 'notch', 'on');
h=findobj(gca,'tag','Outliers');
delete(h);
ylim([0 2000]);
xticklabel_rotate((1:6),45,{{'Neg2_1'},{'Neg2_2'}, {'Neg2_3'},...
    {'MCAK2_1'}, {'MCAK2_2'}, {'MCAK2_3'}}, 'Interpreter', 'none')
ylabel ('Average Intensity (a.u.)', 'fontweight','bold', 'fontsize', fontsize);

subplot (3, 3, 5) % IntDen per FA
boxplot(IntDen_pooled, Group_name, 'notch', 'on');
h=findobj(gca,'tag','Outliers');
delete(h);
ylim([0 3E5]);
xticklabel_rotate((1:6),45,{{'Neg2_1'},{'Neg2_2'}, {'Neg2_3'},...
    {'MCAK2_1'}, {'MCAK2_2'}, {'MCAK2_3'}}, 'Interpreter', 'none')
ylabel ('Int Intensity of a FA (a.u.)', 'fontweight','bold', 'fontsize', fontsize);

subplot (3, 3, 6) % Total_Area
boxplot(IntDen_per_cell_pooled, Group_name_Number, 'notch', 'on');
xticklabel_rotate((1:6),45,{{'Neg2_1'},{'Neg2_2'}, {'Neg2_3'},...
    {'MCAK2_1'}, {'MCAK2_2'}, {'MCAK2_3'}}, 'Interpreter', 'none')
ylabel ('Int Intensity of a cell (a.u.)', 'fontweight','bold', 'fontsize', fontsize);

subplot (3, 3, 7) % Area
boxplot(Cell_Area_pooled, Group_name_Number);
h=findobj(gca,'tag','Outliers');
delete(h);
xticklabel_rotate((1:6),45,{{'Neg2_1'},{'Neg2_2'}, {'Neg2_3'},...
    {'MCAK2_1'}, {'MCAK2_2'}, {'MCAK2_3'}}, 'Interpreter', 'none')
ylabel ('Cell spread area (µm^{2})', 'fontweight','bold');

subplot (3, 3, 8) % Eccentricity
boxplot(Cell_Eccentricity_pooled, Group_name_Number);
h=findobj(gca,'tag','Outliers');
delete(h);
ylim ([0.2 1]);
xticklabel_rotate((1:6),45,{{'Neg2_1'},{'Neg2_2'}, {'Neg2_3'},...
    {'MCAK2_1'}, {'MCAK2_2'}, {'MCAK2_3'}}, 'Interpreter', 'none')
ylabel ('Eccentricity', 'fontweight','bold');

subplot (3, 3, 9) % Solidity
boxplot(Cell_Solidity_pooled, Group_name_Number);
h=findobj(gca,'tag','Outliers');
delete(h);
ylim ([0.4 1]);
xticklabel_rotate((1:6),45,{{'Neg2_1'},{'Neg2_2'}, {'Neg2_3'},...
    {'MCAK2_1'}, {'MCAK2_2'}, {'MCAK2_3'}}, 'Interpreter', 'none')
ylabel ('Solidity', 'fontweight','bold');

print_save_figure(gcf, 'Fig1.Cell_&_FA_stats', 'Processed');

%% Descriptive statistics
Area = descriptive_stats (Area);
Number = descriptive_stats (Number);
Total_Area = descriptive_stats (Total_Area);
AveDen = descriptive_stats (AveDen);
IntDen = descriptive_stats (IntDen);
IntDen_per_cell = descriptive_stats (IntDen_per_cell);
Cell_Area = descriptive_stats (Cell_Area);
Cell_Eccentricity = descriptive_stats (Cell_Eccentricity);
Cell_Solidity = descriptive_stats (Cell_Solidity);
%% Save stats
save('FA_&_Cell_stats', 'Area', 'Number', 'Total_Area', 'AveDen', 'IntDen',...
    'IntDen_per_cell', 'Cell_Area', 'Cell_Eccentricity', 'Cell_Solidity');


