%% Pooled stats and plots

load ('FA_Feature_stats.mat');
Area_Neg2 = [Area{1,2}; Area{1,3}; Area{1,4}];
Area_MCAK2 = [Area{1,5}; Area{1,6}; Area{1,7}];
Area_pooled = [Area_Neg2; Area_MCAK2]; 

Number_Neg2 = [Number{1,2}; Number{1,3}; Number{1,4}];
Number_MCAK2 = [Number{1,5}; Number{1,6}; Number{1,7}];
Number_pooled = [Number_Neg2; Number_MCAK2]; 

Total_Area_Neg2 = [Total_Area{1,2}; Total_Area{1,3}; Total_Area{1,4}];
Total_Area_MCAK2 = [Total_Area{1,5}; Total_Area{1,6}; Total_Area{1,7}];
Total_Area_pooled = [Total_Area_Neg2; Total_Area_MCAK2]; 

Group_name = [ ones(length(Area_Neg2), 1); ones(length(Area_MCAK2), 1)*2]; 
Group_name_Number = [ ones(length(Number_Neg2), 1); ones(length(Number_MCAK2), 1)*2]; 
Group_name_Total_Area = [ ones(length(Total_Area_Neg2), 1); ones(length(Total_Area_MCAK2), 1)*2];

figure(1)
set_print_page(gcf, 1);
subplot (2, 3, 1) 
boxplot(Area_pooled, Group_name, 'Notch','on');
h=findobj(gca,'tag','Outliers');
delete(h);
ylim([0, 5]);
xticklabel_rotate((1:2),45,{{'Neg2'},{'MCAK2'}}, 'Interpreter', 'none')
ylabel ('Area (µm^{2})', 'fontweight','bold', 'fontsize', fontsize);

subplot (2, 3, 2) 
boxplot(Number_pooled, Group_name_Number, 'Notch','on');
xticklabel_rotate((1:2),45,{{'Neg2'},{'MCAK2'}}, 'Interpreter', 'none')
ylabel ('FA Number/Cell', 'fontweight','bold', 'fontsize', fontsize);

subplot (2, 3, 3) 
boxplot(Total_Area_pooled, Group_name_Total_Area, 'Notch','on');
xticklabel_rotate((1:2),45,{{'Neg2'},{'MCAK2'}}, 'Interpreter', 'none')
ylabel ('Total area (µm^{2})/Cell', 'fontweight','bold', 'fontsize', fontsize);

print_save_figure(gcf, 'Fig2.FA_Area_Num_TotalArea_Pooled', 'Processed');
