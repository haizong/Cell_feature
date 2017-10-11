%% Load .mat file derived from running 'cellFeature_calPlot_Rac.m'.
% go to directory  /Users/hailingzong/Dropbox/7 Thesis/4_Chapter_4/Fig4.4_Rac1_OX

% 3rd code to run after cellSeg_rps_Rac.m.
% This code pools data from individual repeats and plot figure.
% HZ    Oct, 2017, Oakland   MATLAB 2016a

load('cellFeature_stats.mat');
fontsize = 10; 
%%

Area_Control_GFP = [Area{1,2}; Area{1,6}; Area{1,10}; Area{1,14}; Area{1,18}];
Area_MCAK_KD_GFP = [Area{1,3}; Area{1,7}; Area{1,11}; Area{1,15}; Area{1,19}];
Area_Control_GFP_Rac1 = [Area{1,4}; Area{1,8}; Area{1,12}; Area{1,16}; Area{1,20}];
Area_MCAK_KD_GFP_Rac1 = [Area{1,5}; Area{1,9}; Area{1,13}; Area{1,17}; Area{1,21}];
Area_pooled = [Area_Control_GFP; Area_MCAK_KD_GFP; Area_Control_GFP_Rac1; Area_MCAK_KD_GFP_Rac1];

Eccentricity_Control_GFP = [Eccentricity{1,2}; Eccentricity{1,6}; ...
    Eccentricity{1,10}; Eccentricity{1,14}; Eccentricity{1,18}];
Eccentricity_MCAK_KD_GFP = [Eccentricity{1,3}; Eccentricity{1,7}; ...
    Eccentricity{1,11}; Eccentricity{1,15}; Eccentricity{1,19}];
Eccentricity_Control_GFP_Rac1 = [Eccentricity{1,4}; Eccentricity{1,8}; ...
    Eccentricity{1,12}; Eccentricity{1,16}; Eccentricity{1,20}];
Eccentricity_MCAK_KD_GFP_Rac1 = [Eccentricity{1,5}; Eccentricity{1,9}; ...
    Eccentricity{1,13}; Eccentricity{1,17}; Eccentricity{1,21}];
Eccentricity_pooled = [Eccentricity_Control_GFP; Eccentricity_MCAK_KD_GFP; Eccentricity_Control_GFP_Rac1; Eccentricity_MCAK_KD_GFP_Rac1];

Solidity_Control_GFP = [Solidity{1,2}; Solidity{1,6}; ...
    Solidity{1,10}; Solidity{1,14}; Solidity{1,18}];
Solidity_MCAK_KD_GFP = [Solidity{1,3}; Solidity{1,7}; ...
    Solidity{1,11}; Solidity{1,15}; Solidity{1,19}];
Solidity_Control_GFP_Rac1 = [Solidity{1,4}; Solidity{1,8}; ...
    Solidity{1,12}; Solidity{1,16}; Solidity{1,20}];
Solidity_MCAK_KD_GFP_Rac1 = [Solidity{1,5}; Solidity{1,9}; ...
    Solidity{1,13}; Solidity{1,17}; Solidity{1,21}];
Solidity_pooled = [Solidity_Control_GFP; Solidity_MCAK_KD_GFP; ...
    Solidity_Control_GFP_Rac1; Solidity_MCAK_KD_GFP_Rac1];

GFP_aveIntensity_Control_GFP = [GFP_aveIntensity{1,2}; GFP_aveIntensity{1,6}; ...
    GFP_aveIntensity{1,10}; GFP_aveIntensity{1,14}; GFP_aveIntensity{1,18}];
GFP_aveIntensity_MCAK_KD_GFP = [GFP_aveIntensity{1,3}; GFP_aveIntensity{1,7}; ...
    GFP_aveIntensity{1,11}; GFP_aveIntensity{1,15}; GFP_aveIntensity{1,19}];
GFP_aveIntensity_Control_GFP_Rac1 = [GFP_aveIntensity{1,4}; GFP_aveIntensity{1,8}; ...
    GFP_aveIntensity{1,12}; GFP_aveIntensity{1,16}; GFP_aveIntensity{1,20}];
GFP_aveIntensity_MCAK_KD_GFP_Rac1 = [GFP_aveIntensity{1,5}; GFP_aveIntensity{1,9}; ...
    GFP_aveIntensity{1,13}; GFP_aveIntensity{1,17}; GFP_aveIntensity{1,21}];
GFP_aveIntensity_pooled = [GFP_aveIntensity_Control_GFP; GFP_aveIntensity_MCAK_KD_GFP; ...
    GFP_aveIntensity_Control_GFP_Rac1; GFP_aveIntensity_MCAK_KD_GFP_Rac1];

Group_name = [ ones(length(Area_Control_GFP), 1); ones(length(Area_MCAK_KD_GFP), 1)*2; ...
    ones(length(Area_Control_GFP_Rac1), 1)*3; ones(length(Area_MCAK_KD_GFP_Rac1), 1)*4 ];

%%
figure()
set_print_page(gcf, 1);
fig1 = subplot (2, 3, 1);
boxplot(Area_pooled, Group_name, 'Notch','on', 'Symbol', 'k.', 'OutlierSize', 4);
ylim([0, 8000]);
xticklabel_rotate((1:4),45,{{'Control: GFP'},{'MCAK-KD: GFP'},...
    {'Control: GFP-Rac1'},{'MCAK-KD: GFP-Rac1'} }, 'Interpreter', 'none')
box(fig1,'off');
ylabel ('Area (µm^{2})', 'fontsize', fontsize);

fig2 = subplot (2, 3, 2);
boxplot(Eccentricity_pooled, Group_name, 'Notch','on', 'Symbol', 'k.', 'OutlierSize', 4);
xticklabel_rotate((1:4),45,{{'Control: GFP'},{'MCAK-KD: GFP'},...
    {'Control: GFP-Rac1'},{'MCAK-KD: GFP-Rac1'} }, 'Interpreter', 'none')
% delete(h);
ylim([0, 1]);
box(fig2,'off');
ylabel('Eccentricity', 'fontsize', fontsize);

fig3 = subplot (2, 3, 3);
boxplot(Solidity_pooled, Group_name, 'Notch','on', 'Symbol', 'k.', 'OutlierSize', 4);
xticklabel_rotate((1:4),45,{{'Control: GFP'},{'MCAK-KD: GFP'},...
    {'Control: GFP-Rac1'},{'MCAK-KD: GFP-Rac1'} }, 'Interpreter', 'none')
ylim([0.5, 1]);
box(fig3,'off');
ylabel ('Solidity', 'fontsize', fontsize);

fig4 = subplot (2, 3, 4);
boxplot(GFP_aveIntensity_pooled, Group_name, 'Notch','on', 'Symbol', 'k.', 'OutlierSize', 4);
xticklabel_rotate((1:4),45,{{'Control: GFP'},{'MCAK-KD: GFP'},...
    {'Control: GFP-Rac1'},{'MCAK-KD: GFP-Rac1'} }, 'Interpreter', 'none')
ylim([0 3000]);
set(gca,'yTick',(0:500:3000))
box(fig4,'off');
ylabel ('GFP average intensity', 'fontsize', fontsize);
%%
print_save_figure(gcf, 'Fig3.Area_Eccentricity_Solidity_GFPIntensity_Pooled', 'Processed');

%%
stats_Area = mwwtest( Area_Control_GFP, Area_MCAK_KD_GFP );
stats_Eccentricity = mwwtest( Eccentricity_Control_GFP, Eccentricity_MCAK_KD_GFP );
stats_Solidity = mwwtest( Solidity_Control_GFP, Solidity_MCAK_KD_GFP );
stats_GFP_AveIntensity = mwwtest( GFP_aveIntensity_Control_GFP, GFP_aveIntensity_MCAK_KD_GFP );

save ('MannWhitneyTest_stats', 'stats_Area', 'stats_Eccentricity', 'stats_GFP_AveIntensity',...
    'stats_Solidity');