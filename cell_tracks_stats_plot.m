% go to upper layer of folder
% /Users/hailingzong/Dropbox/4 Cell_migration/Imaging/3.Timelapse/Individual
%% pooled_data and figure
clc; clear;
fontsize = 12; 
Neg2_R1 = load('Neg2_R1_crd_pooled.mat');
MCAK2_R1 = load('MCAK2_R1_crd_pooled.mat');
Neg2_R2 = load('Neg2_R2_crd_pooled.mat');
MCAK2_R2 = load('MCAK2_R2_crd_pooled.mat');

%%
Neg2_cell_num = length(Neg2_R1.crd_pooled)+length(Neg2_R2.crd_pooled);
Neg2_crd_pooled = [ Neg2_R1.crd_pooled(:); Neg2_R2.crd_pooled(:) ];

MCAK2_cell_num = length(MCAK2_R1.crd_pooled)+length(MCAK2_R2.crd_pooled);
MCAK2_crd_pooled = [ MCAK2_R1.crd_pooled(:); MCAK2_R2.crd_pooled(:) ];

%%
figure()
for i = 1:length(Neg2_crd_pooled)
    plot(Neg2_crd_pooled{i}(:,1), Neg2_crd_pooled{i}(:,2), 'linewidth', 2); hold on
    xlim([-400 400]); ylim ([-400 400]);
    xlabel ('Distance (pixel)', 'fontsize', fontsize);
    ylabel ('Distance (pixel)', 'fontsize', fontsize);
    title (['Neg2  n=_', num2str(length(Neg2_crd_pooled))], 'Interpreter', 'none');
end
print_save_figure(gcf, 'Neg2_crd_tracks');

%%
figure()
for i = 1:length(MCAK2_crd_pooled)
    plot(MCAK2_crd_pooled{i}(:,1), MCAK2_crd_pooled{i}(:,2), 'linewidth', 2); hold on
    xlim([-400 400]); ylim ([-400 400]);
    xlabel ('Distance (pixel)', 'fontsize', fontsize);
    ylabel ('Distance (pixel)', 'fontsize', fontsize);
    title (['MCAK2  n=_', num2str(length(MCAK2_crd_pooled))], 'Interpreter', 'none');
end
print_save_figure(gcf, 'MCAK2_crd_tracks');
close all; 
%%
save ('Tracks_crd', 'Neg2_cell_num', 'Neg2_crd_pooled', 'MCAK2_cell_num', 'MCAK2_crd_pooled'); 
