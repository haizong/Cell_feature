clc; clear;

%% Load .mat file from each data set.
% go to directory  /Users/hailingzong/Dropbox/5 Paper/2017_migration_paper/
% Fig3_focal_adhesion/GFP-Paxillin-live_pDV/20170526_Analysis_new_fit

% This code calculate descriptive stats and box plot each data set. 
% HZ    May, 2017, Berkeley   MATLAB 2016a

%%
load ('Neg2.mat');
load ('MCAK2.mat');
fontsize = 10; 

%%  Plot each data set

Ka_pooled = [Neg2_Ka_R1; Neg2_Ka_R2; Neg2_Ka_R3; MCAK2_Ka_R1; MCAK2_Ka_R2; MCAK2_Ka_R3];
Kd_pooled = [Neg2_Kd_R1; Neg2_Kd_R2; Neg2_Kd_R3; MCAK2_Kd_R1; MCAK2_Kd_R2; MCAK2_Kd_R3];
lt_pooled = [Neg2_lt_R1; Neg2_lt_R2; Neg2_lt_R3; MCAK2_lt_R1; MCAK2_lt_R2; MCAK2_lt_R3];

Group_name = [ ones(1, length(Neg2_Ka_R1)), ones(1, length(Neg2_Ka_R2))*2, ones(1, length(Neg2_Ka_R3))*3,...
    ones(1, length(MCAK2_Ka_R1))*4, ones(1, length(MCAK2_Ka_R2))*5, ones(1, length(MCAK2_Ka_R3))*6]; 

figure()
set_print_page(gcf, 0);
subplot (2, 3, 1) % Ka_individual
boxplot(Ka_pooled, Group_name, 'notch', 'on', 'Symbol', 'k.', 'OutlierSize', 4);
xticklabel_rotate((1:6),45,{{'Neg2_1'},{'Neg2_2'},{'Neg2_3'}, ...
    {'MCAK2_1'}, {'MCAK2_2'}, {'MCAK2_3'}},'Interpreter', 'none', 'fontsize', fontsize);
ylim ([0 1.2]);
ylabel ('Assembly rate constant (×10^-2 s^-1)', 'fontsize', fontsize);

subplot (2, 3, 2) % Kd_individual
boxplot(Kd_pooled, Group_name, 'notch', 'on', 'Symbol', 'k.', 'OutlierSize', 4);
ylim ([0 0.6]);
xticklabel_rotate((1:6),45,{{'Neg2_1'},{'Neg2_2'},{'Neg2_3'}, ...
    {'MCAK2_1'}, {'MCAK2_2'}, {'MCAK2_3'}},'Interpreter', 'none', 'fontsize', fontsize);
ylabel ('Disassembly rate constant (×10^-2 s^-1)', 'fontsize', fontsize);

subplot (2, 3, 3) % Lifetime_individual
boxplot(lt_pooled, Group_name, 'notch', 'on', 'Symbol', 'k.', 'OutlierSize', 4);
ylim ([0 120]);
xticklabel_rotate((1:6),45,{{'Neg2_1'},{'Neg2_2'},{'Neg2_3'}, ...
    {'MCAK2_1'}, {'MCAK2_2'}, {'MCAK2_3'}},'Interpreter', 'none', 'fontsize', fontsize);
ylabel ('Lifetime (min)', 'fontsize', fontsize);

%% Plot combined data set
Ka_Neg2 = [Neg2_Ka_R1; Neg2_Ka_R2; Neg2_Ka_R3];
Ka_MCAK2 = [MCAK2_Ka_R1; MCAK2_Ka_R2; MCAK2_Ka_R3];

Kd_Neg2 = [Neg2_Kd_R1; Neg2_Kd_R2; Neg2_Kd_R3];
Kd_MCAK2 = [MCAK2_Kd_R1; MCAK2_Kd_R2; MCAK2_Kd_R3];

lt_Neg2 = [Neg2_lt_R1; Neg2_lt_R2;  Neg2_lt_R3;];
lt_MCAK2 = [MCAK2_lt_R1; MCAK2_lt_R2; MCAK2_lt_R3];

Group_N2_M2 = [ones(1, length(Ka_Neg2)), ones(1, length(Ka_MCAK2))*2];

subplot (2, 3, 4) % Ka_combined
boxplot(Ka_pooled, Group_N2_M2, 'notch', 'on', 'Symbol', 'k.', 'OutlierSize', 4);
ylim ([0 1.2]);
xticklabel_rotate((1:2),45,{{'Control'}, {'MCAK KD'}},'Interpreter', 'none', 'fontsize', fontsize);
ylabel ('Assembly rate constant (×10^-2 s^-1)', 'fontsize', fontsize);

subplot (2, 3, 5) % Kd_combined
boxplot(Kd_pooled, Group_N2_M2, 'notch', 'on', 'Symbol', 'k.', 'OutlierSize', 4);
ylim ([0 0.6]);
xticklabel_rotate((1:2),45,{{'Control'}, {'MCAK KD'}},'Interpreter', 'none', 'fontsize', fontsize);
ylabel ('Disassembly rate constant (×10^-2 s^-1)', 'fontsize', fontsize);

subplot (2, 3, 6) % Lifetime_combined
boxplot(lt_pooled, Group_N2_M2, 'notch', 'on', 'Symbol', 'k.', 'OutlierSize', 4);
ylim ([0 120]);
xticklabel_rotate((1:2),45,{{'Control'}, {'MCAK KD'}},'Interpreter', 'none', 'fontsize', fontsize);
ylabel ('Lifetime (min)', 'fontsize', fontsize);

%%
print_save_figure(gcf, 'Fig1.FA_plot_individual_combined', 'Processed');

stats_Ka = mwwtest( Ka_Neg2, Ka_MCAK2 ); 
stats_Kd = mwwtest( Kd_Neg2, Kd_MCAK2 ); 
stats_lt = mwwtest( lt_Neg2, lt_MCAK2 ); 

save ('FA_parameter_analysis'); 










