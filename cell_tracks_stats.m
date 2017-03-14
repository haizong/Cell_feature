% Calculate distance, velocity, path, and directional persistence of
% migrating cells from track coordinates. Use Mann-whitney to calculate
% stastistical significance. 
% 4th/last code to run. 
% go to directory /Users/hailingzong/Dropbox/4 Cell_migration/Imaging/3.Timelapse/Individual

%%
close all; clc; clear; 
load('Tracks_crd.mat');

dt = 10;  % time interval = 10 min

for i = 1:length(Neg2_crd_pooled)
    d = sqrt((Neg2_crd_pooled{i}(end, 1)- Neg2_crd_pooled{i}(1, 1))^2 + ...
        (Neg2_crd_pooled{i}(end, 2)- Neg2_crd_pooled{i}(1, 2))^2);
    Neg2_crd_pooled{i,2} = d;  % save displacement in column 2
    
    n_frames = length(Neg2_crd_pooled{i})-1;
    Neg2_dist_all = nan(n_frames -1, 1);
    Neg2_vel_all = nan(n_frames -1, 1);
    for j = 1:(n_frames - 1)
        Neg2_dist_all (j, 1) = pdist([Neg2_crd_pooled{i}(j, 1), Neg2_crd_pooled{i}(j, 2); ...
            Neg2_crd_pooled{i}(j+1, 1), Neg2_crd_pooled{i}(j+1, 2)]);
        Neg2_vel_all(j, 1) = Neg2_dist_all(j, 1)/dt;
        Neg2_crd_pooled{i,3} = Neg2_dist_all;  % distance traveled in each time frame
        Neg2_crd_pooled{i,4} = Neg2_vel_all*60;  % velocity unit convert to pixel/hr
        Neg2_crd_pooled{i,5} = mean(Neg2_crd_pooled{i,4}); % average velocity
        Neg2_crd_pooled{i,6} = sum(Neg2_crd_pooled{i,3}); % path = sum of individual distance
        Neg2_crd_pooled{i,7} = Neg2_crd_pooled{i,2}/Neg2_crd_pooled{i,6};
        % directional persistence = displacement/path
    end
end


for i = 1:length(MCAK2_crd_pooled)
    d = sqrt((MCAK2_crd_pooled{i}(end, 1)- MCAK2_crd_pooled{i}(1, 1))^2 + ...
        (MCAK2_crd_pooled{i}(end, 2)- MCAK2_crd_pooled{i}(1, 2))^2);
    MCAK2_crd_pooled{i,2} = d;  % save displacement in column 2
    
    n_frames = length(MCAK2_crd_pooled{i})-1;
    MCAK2_dist_all = nan(n_frames -1, 1);
    MCAK2_vel_all = nan(n_frames -1, 1);
    for j = 1:(n_frames - 1)
        MCAK2_dist_all (j, 1) = pdist([MCAK2_crd_pooled{i}(j, 1), MCAK2_crd_pooled{i}(j, 2); ...
            MCAK2_crd_pooled{i}(j+1, 1), MCAK2_crd_pooled{i}(j+1, 2)]);
        MCAK2_vel_all(j, 1) = MCAK2_dist_all(j, 1)/dt;
        
        MCAK2_crd_pooled{i,3} = MCAK2_dist_all;  % distance traveled in each time frame
        MCAK2_crd_pooled{i,4} = MCAK2_vel_all*60;  % velocity, unit convert to pixel/hr
        MCAK2_crd_pooled{i,5} = mean(MCAK2_crd_pooled{i,4}); % average_velocity
        MCAK2_crd_pooled{i,6} = sum(MCAK2_crd_pooled{i,3}); % sum of individual distance = path
        MCAK2_crd_pooled{i,7} = MCAK2_crd_pooled{i,2}/MCAK2_crd_pooled{i,6};
    end
end

displacement_pooled = [Neg2_crd_pooled{:,2}, MCAK2_crd_pooled{:,2}];
velocity_pooled = [Neg2_crd_pooled{:,5},  MCAK2_crd_pooled{:,5}];  % hr
path_pooled = [Neg2_crd_pooled{:,6},  MCAK2_crd_pooled{:,6}];
directionality_pooled = [Neg2_crd_pooled{:,7},  MCAK2_crd_pooled{:,7}];

Group_name = [ ones(Neg2_cell_num, 1); ones(MCAK2_cell_num, 1)*2];

figure()
subplot (2, 3, 1)
boxplot(displacement_pooled, Group_name, 'Notch','on');
xticklabel_rotate((1:2),45,{{'Control'},{'MCAK KD'}}, 'Interpreter', 'none');
ylabel ('Displacement (µm)');

subplot (2, 3, 2)
boxplot(velocity_pooled, Group_name, 'Notch','on');
xticklabel_rotate((1:2),45,{{'Control'},{'MCAK KD'}}, 'Interpreter', 'none');
ylabel ('Speed (µm/hr)');

subplot (2, 3, 3)
boxplot(path_pooled, Group_name, 'Notch','on');
xticklabel_rotate((1:2),45,{{'Control'},{'MCAK KD'}}, 'Interpreter', 'none');
ylabel ('Path (µm)');

subplot (2, 3, 4)
boxplot(directionality_pooled, Group_name, 'Notch','on');
xticklabel_rotate((1:2),45,{{'Control'},{'MCAK KD'}}, 'Interpreter', 'none');
ylabel ('Directional persistence');

print_save_figure(gcf, 'Track_stats_Disp_Speed_Path_Persistency');

%% Calculate stats using Mann-Whitney-Wilcoxon non parametric test for two unpaired groups.
% https://www.mathworks.com/matlabcentral/fileexchange/25830-mwwtest-x1-x2-

stats_displacement = mwwtest( [Neg2_crd_pooled{:,2}], [MCAK2_crd_pooled{:,2}] ); 
stats_velocity = mwwtest( [Neg2_crd_pooled{:,5}], [MCAK2_crd_pooled{:,5}] ); 
stats_path = mwwtest( [Neg2_crd_pooled{:,6}], [MCAK2_crd_pooled{:,6}] ); 
stats_directional_persistence = mwwtest( [Neg2_crd_pooled{:,7}], [MCAK2_crd_pooled{:,7}] ); 

%%
save ('Tracks_stats', 'Neg2_crd_pooled', 'MCAK2_crd_pooled', 'stats_directional_persistence',...
    'stats_displacement', 'stats_path', 'stats_velocity'); 
