% Pool data from individual data set (Neg/MCAK each day). Plot distance figure. 
% 2nd code to run. 
% go to directory containing folder of image sequences, eg
% Dropbox/4 Cell_migration/Imaging/3.Timelapse/Individual/20170114_MCAK2/image_sequence

%%
clc; clear;

fontsize = 12;
cell_info = dir('2017*');
cell_info = cell_info(arrayfun(@(x) x.name(1), cell_info) ~= '.');
crd_pooled = cell(length(cell_info), 1);

for i = 1:length(cell_info)
    load([cell_info(i).name, '.mat']);  % for go to each folder containing data set
    
    crd = [];
    for k = 1:2:length(folder_info)
        crd = [crd; folder_info(k).crd - folder_info(1).crd]; % bring start point the origin (0,0)
        crd_convert = crd * 0.321;  % Convert to µm.  60x oil on pDV, 1pixel=0.321µm. 
    end
    crd_pooled{i} = crd_convert;
end


fprintf ('Manually change the name of crd_pooled.mat to specific repeats, \nuch as "Neg2_R2_crd_pooled.mat"!!!\n');

% save ('Neg2_R1_crd_pooled', 'crd_pooled');
% save ('MCAK2_R1_crd_pooled', 'crd_pooled');
save ('Neg2_R2_crd_pooled', 'crd_pooled');
% save ('MCAK2_R2_crd_pooled', 'crd_pooled');
% save ('Neg2_R3_crd_pooled', 'crd_pooled');
% save ('MCAK2_R3_crd_pooled', 'crd_pooled');
%% plot

for i = 1:length(crd_pooled)
    plot(crd_pooled{i}(:,1), crd_pooled{i}(:,2), 'linewidth', 2); hold on
    xlim([-250 250]); ylim ([-250 250]);
    xlabel ('Distance (pixel)', 'fontsize', fontsize);
    ylabel ('Distance (pixel)', 'fontsize', fontsize);
    title ([cell_info(i).name(1:13), '__n=_', num2str(length(cell_info))], 'Interpreter', 'none');
end
print_save_figure(gcf, 'Fig1.Distance_µm');

