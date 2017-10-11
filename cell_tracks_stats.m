% 4th/last code to run.
% Calculate total distance, overal velocity, path, and directional persistence of
% migrating cells from track coordinates. Use Mann-whitney to calculate stastistical significance.
% Data organization: 
% Column (1): cooridnates; C2: displacement;  C3: displacement_per_10min; 
% C4: Velocity_per_10min; C5: velocity_4h; C6: path; 
% C7: directional_persistence;  C8: Velocity=total distance/4h
% go to directory /Users/hailingzong/Dropbox/7 Thesis/4_Chapter_4/...
%            Fig4.1_migration/4.1C_Timelapse_pDV/RawData_and_Analysis

%%
close all; clc; clear;
load('Tracks_crd.mat');
fontsize = 16; 
dt = 10;  % time interval = 10 min
%%
for i = 1:length(Neg2_crd_pooled)
    d = sqrt((Neg2_crd_pooled{i}(end, 1)- Neg2_crd_pooled{i}(1, 1))^2 + ...
        (Neg2_crd_pooled{i}(end, 2)- Neg2_crd_pooled{i}(1, 2))^2);
    % save displacement in column 2 (µm)
    Neg2_crd_pooled{i,2} = d;
    
    n_frames = length(Neg2_crd_pooled{i})-1;
    Neg2_dist_all = nan(n_frames -1, 1);
    Neg2_vel_all = nan(n_frames -1, 1);
    for j = 1:(n_frames - 1)
        Neg2_dist_all (j, 1) = pdist([Neg2_crd_pooled{i}(j, 1), Neg2_crd_pooled{i}(j, 2); ...
            Neg2_crd_pooled{i}(j+1, 1), Neg2_crd_pooled{i}(j+1, 2)]);
        Neg2_vel_all(j, 1) = Neg2_dist_all(j, 1)/dt;
        % distance traveled in each time frame
        Neg2_crd_pooled{i,3} = Neg2_dist_all;
        % velocity unit convert to µm/hr
        Neg2_crd_pooled{i,4} = Neg2_vel_all*60;
        % average velocity (µm/hr)
        Neg2_crd_pooled{i,5} = mean(Neg2_crd_pooled{i,4});
        % path = sum of individual distance (µm)
        Neg2_crd_pooled{i,6} = sum(Neg2_crd_pooled{i,3});
        % directional persistence = displacement/path
        Neg2_crd_pooled{i,7} = Neg2_crd_pooled{i,2}/Neg2_crd_pooled{i,6};
        % overall velocity (µm/hr)
        Neg2_crd_pooled{i,8} = Neg2_crd_pooled{i,2}/4;
    end
end


for i = 1:length(MCAK2_crd_pooled)
    d = sqrt((MCAK2_crd_pooled{i}(end, 1)- MCAK2_crd_pooled{i}(1, 1))^2 + ...
        (MCAK2_crd_pooled{i}(end, 2)- MCAK2_crd_pooled{i}(1, 2))^2);
    % save displacement in column 2
    MCAK2_crd_pooled{i,2} = d;  
    
    n_frames = length(MCAK2_crd_pooled{i})-1;
    MCAK2_dist_all = nan(n_frames -1, 1);
    MCAK2_vel_all = nan(n_frames -1, 1);
    for j = 1:(n_frames - 1)
        MCAK2_dist_all (j, 1) = pdist([MCAK2_crd_pooled{i}(j, 1), MCAK2_crd_pooled{i}(j, 2); ...
            MCAK2_crd_pooled{i}(j+1, 1), MCAK2_crd_pooled{i}(j+1, 2)]);
        MCAK2_vel_all(j, 1) = MCAK2_dist_all(j, 1)/dt;
        % distance traveled in each time frame
        MCAK2_crd_pooled{i,3} = MCAK2_dist_all;  
        % velocity, unit convert to µm/hr
        MCAK2_crd_pooled{i,4} = MCAK2_vel_all*60;  
        % average_velocity
        MCAK2_crd_pooled{i,5} = mean(MCAK2_crd_pooled{i,4}); 
        % sum of individual distance = path
        MCAK2_crd_pooled{i,6} = sum(MCAK2_crd_pooled{i,3}); 
        % directional persistence = displacement/path
        MCAK2_crd_pooled{i,7} = MCAK2_crd_pooled{i,2}/MCAK2_crd_pooled{i,6};
        % overall velocity (µm/hr)
        MCAK2_crd_pooled{i,8} = MCAK2_crd_pooled{i,2}/4;
    end
end

displacement_pooled = [Neg2_crd_pooled{:,2}, MCAK2_crd_pooled{:,2}];
velocity_pooled = [Neg2_crd_pooled{:,8},  MCAK2_crd_pooled{:,8}];  
path_pooled = [Neg2_crd_pooled{:,6},  MCAK2_crd_pooled{:,6}];
directionality_pooled = [Neg2_crd_pooled{:,7},  MCAK2_crd_pooled{:,7}];

Group_name = [ ones(Neg2_cell_num, 1); ones(MCAK2_cell_num, 1)*2];

%%
figure()
set_print_page(gcf, 1);
fig1 = subplot(2, 2, 1);
boxplot(displacement_pooled, Group_name, 'Notch','on', 'Symbol', 'k.', 'OutlierSize', 4);
xticklabel_rotate([1:2],45,{{'Control'},{'MCAK KD'}}, 'Interpreter', 'none');
ylim ([0, 250]);
box(fig1,'off');
set(findobj(gca,'type','line'),'linew',1); set(gca,'linew',1 );
ylabel ('Displacement (µm)', 'fontsize', fontsize, 'color', 'k');

fig2 = subplot (2, 2, 2);
boxplot(velocity_pooled, Group_name, 'Notch','on', 'Symbol', 'k.', 'OutlierSize', 4);
xticklabel_rotate((1:2),45,{{'Control'},{'MCAK KD'}}, 'Interpreter', 'none');
ylim ([0, 60]);
box(fig2,'off');
set(findobj(gca,'type','line'),'linew',1); set(gca,'linew',1 );
ylabel ('Speed (µm/hr)', 'fontsize', fontsize, 'color', 'k');

fig3 = subplot (2, 2, 3);
boxplot(path_pooled, Group_name, 'Notch','on', 'Symbol', 'k.', 'OutlierSize', 4);
xticklabel_rotate((1:2),45,{{'Control'},{'MCAK KD'}}, 'Interpreter', 'none');
ylim ([0, 300]);
box(fig3,'off');
set(findobj(gca,'type','line'),'linew',1); set(gca,'linew',1 );
ylabel ('Path (µm)', 'fontsize', fontsize, 'color', 'k');

fig4 = subplot (2, 2, 4);
boxplot(directionality_pooled, Group_name, 'Notch','on', 'Symbol', 'k.', 'OutlierSize', 4);
xticklabel_rotate((1:2),45,{{'Control'},{'MCAK KD'}}, 'Interpreter', 'none');
ylim ([0, 1.1]);
box(fig4,'off');
set(findobj(gca,'type','line'),'linew',1); set(gca,'linew',1 );
ylabel ('Directional persistence', 'fontsize', fontsize, 'color', 'k');

print_save_figure(gcf, 'Track_stats_Disp_Speed_Path_Persistency');

%% Calculate stats using Mann-Whitney-Wilcoxon non parametric test for two unpaired groups.
% https://www.mathworks.com/matlabcentral/fileexchange/25830-mwwtest-x1-x2-
cprintf ('red', 'stats_displacement\n');  
stats_displacement = mwwtest( [Neg2_crd_pooled{:,2}], [MCAK2_crd_pooled{:,2}] );
cprintf ('red', 'stats_velocity\n');
stats_velocity = mwwtest( [Neg2_crd_pooled{:,8}], [MCAK2_crd_pooled{:,8}] );
cprintf ('red', 'stats_path\n');
stats_path = mwwtest( [Neg2_crd_pooled{:,6}], [MCAK2_crd_pooled{:,6}] );
cprintf ('red', 'stats_directional_persistence\n');
stats_directional_persistence = mwwtest( [Neg2_crd_pooled{:,7}], [MCAK2_crd_pooled{:,7}] );

%%
save ('Tracks_stats_171010', 'Neg2_crd_pooled', 'MCAK2_crd_pooled', 'stats_directional_persistence',...
    'stats_displacement', 'stats_path', 'stats_velocity');
