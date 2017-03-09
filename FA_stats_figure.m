%% Pooled stats and plots
clc; clear; 
load ('FA_Feature_stats.mat');

%%
Area_Neg2 = [Area{1,2}; Area{1,3}; Area{1,4}];
Area_MCAK2 = [Area{1,5}; Area{1,6}; Area{1,7}];
Area_pooled = [Area_Neg2; Area_MCAK2]; 

Number_Neg2 = [Number{1,2}; Number{1,3}; Number{1,4}];
Number_MCAK2 = [Number{1,5}; Number{1,6}; Number{1,7}];
Number_pooled = [Number_Neg2; Number_MCAK2]; 

Total_Area_Neg2 = [Total_Area{1,2}; Total_Area{1,3}; Total_Area{1,4}];
Total_Area_MCAK2 = [Total_Area{1,5}; Total_Area{1,6}; Total_Area{1,7}];
Total_Area_pooled = [Total_Area_Neg2; Total_Area_MCAK2]; 

AveDen_Neg2 = [AveDen{1,2}; AveDen{1,3}; AveDen{1,4}];
AveDen_MCAK2 = [AveDen{1,5}; AveDen{1,6}; AveDen{1,7}];
AveDen_pooled = [AveDen_Neg2; AveDen_MCAK2]; 

IntDen_Neg2 = [IntDen{1,2}; IntDen{1,3}; IntDen{1,4}];
IntDen_MCAK2 = [IntDen{1,5}; IntDen{1,6}; IntDen{1,7}];
IntDen_pooled = [IntDen_Neg2; IntDen_MCAK2]; 

IntDen_per_cell_Neg2 = [IntDen_per_cell{1,2}; IntDen_per_cell{1,3}; IntDen_per_cell{1,4}];
IntDen_per_cell_MCAK2 = [IntDen_per_cell{1,5}; IntDen_per_cell{1,6}; IntDen_per_cell{1,7}];
IntDen_per_cell_pooled = [IntDen_per_cell_Neg2; IntDen_per_cell_MCAK2]; 

Group_name = [ ones(length(Area_Neg2), 1); ones(length(Area_MCAK2), 1)*2]; 
Group_name_Number = [ ones(length(Number_Neg2), 1); ones(length(Number_MCAK2), 1)*2]; 
Group_name_Total_Area = [ ones(length(Total_Area_Neg2), 1); ones(length(Total_Area_MCAK2), 1)*2];

figure(1)
set_print_page(gcf, 1);
subplot (2, 3, 1) 
boxplot(Area_pooled, Group_name, 'Notch','on');
h=findobj(gca,'tag','Outliers');
delete(h);
ylim([0, 3]);
xticklabel_rotate((1:2),45,{{'Control siRNA'},{'MCAK siRNA'}}, 'Interpreter', 'none');
ylabel ('Area (µm^{2})');

subplot (2, 3, 2) 
boxplot(Number_pooled, Group_name_Number, 'Notch','on');
h=findobj(gca,'tag','Outliers');
delete(h);
ylim([-50, 500]);
xticklabel_rotate((1:2),45,{{'Control siRNA'},{'MCAK siRNA'}}, 'Interpreter', 'none');
ylabel ('FA Number/Cell');

subplot (2, 3, 3) 
boxplot(Total_Area_pooled, Group_name_Total_Area, 'Notch','on');
h=findobj(gca,'tag','Outliers');
delete(h);
ylim([-50, 600]);
xticklabel_rotate((1:2),45,{{'Control siRNA'},{'MCAK siRNA'}}, 'Interpreter', 'none');
ylabel ('Total area (µm^{2})/Cell');

subplot (2, 3, 4) % AveDen
boxplot(AveDen_pooled, Group_name, 'notch', 'on');
h=findobj(gca,'tag','Outliers');
delete(h);
ylim([0 2000]);
xticklabel_rotate((1:2),45,{{'Control siRNA'},{'MCAK siRNA'}}, 'Interpreter', 'none');
ylabel ('Average Intensity (a.u.)');

subplot (2, 3, 5) % IntDen per FA
boxplot(IntDen_pooled, Group_name, 'notch', 'on');
h=findobj(gca,'tag','Outliers');
delete(h);
ylim([0 3E5]);
xticklabel_rotate((1:2),45,{{'Control siRNA'},{'MCAK siRNA'}}, 'Interpreter', 'none');
ylabel ('Integrated Intensity per FA (a.u.)');

subplot (2, 3, 6) % Total_Area
boxplot(IntDen_per_cell_pooled, Group_name_Number, 'notch', 'on');
xticklabel_rotate((1:2),45,{{'Control siRNA'},{'MCAK siRNA'}}, 'Interpreter', 'none');
ylabel ('Integrated Intensity per cell (a.u.)');

print_save_figure(gcf, 'Fig2.FA_Area_Num_TotalArea_Int_Pooled', 'Processed');

%% Calculate stats using Mann-Whitney-Wilcoxon non parametric test for two unpaired groups.
% https://www.mathworks.com/matlabcentral/fileexchange/25830-mwwtest-x1-x2-

% stats_Area = mwwtest( Area_Neg2, Area_MCAK2 ); 
% stats_Number = mwwtest( Number_Neg2, Number_MCAK2 ); 
% stats_Total_Area = mwwtest( Total_Area_Neg2, Total_Area_MCAK2 ); 

