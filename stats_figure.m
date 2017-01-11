
load('cellFeature_stats.mat');

Area_Neg2 = [Area{1,2}; Area{1,3}; Area{1,4}];
Area_MCAK2 = [Area{1,5}; Area{1,6}; Area{1,7}];
Area_pooled = [Area_Neg2; Area_MCAK2]; 

Eccentricity_Neg2 = [Eccentricity{1,2}; Eccentricity{1,3}; Eccentricity{1,4}];
Eccentricity_MCAK2 = [Eccentricity{1,5}; Eccentricity{1,6}; Eccentricity{1,7}];
Eccentricity_pooled = [Eccentricity_Neg2; Eccentricity_MCAK2]; 

Aspect_Ratio_Neg2 = [Aspect_Ratio{1,2}; Aspect_Ratio{1,3}; Aspect_Ratio{1,4}];
Aspect_Ratio_MCAK2 = [Aspect_Ratio{1,5}; Aspect_Ratio{1,6}; Aspect_Ratio{1,7}];
Aspect_Ratio_pooled = [Aspect_Ratio_Neg2; Aspect_Ratio_MCAK2]; 

Solidity_Neg2 = [Solidity{1,2}; Solidity{1,3}; Solidity{1,4}];
Solidity_MCAK2 = [Solidity{1,5}; Solidity{1,6}; Solidity{1,7}];
Solidity_pooled = [Solidity_Neg2; Solidity_MCAK2]; 

Group_name = [ ones(length(Area_Neg2), 1); ones(length(Area_MCAK2), 1)*2]; 

figure(1)
set_print_page(gcf, 1);
subplot (2, 3, 1) 
boxplot(Area_pooled, Group_name, 'Notch','on');
xticklabel_rotate((1:2),45,{{'Neg2'},{'MCAK2'}}, 'Interpreter', 'none')
title ('Area (µm^{2})');

subplot (2, 3, 2) 
boxplot(Eccentricity_pooled, Group_name, 'Notch','on');
xticklabel_rotate((1:2),45,{{'Neg2'},{'MCAK2'}}, 'Interpreter', 'none')
title ('Eccentricity');

subplot (2, 3, 3) 
boxplot(Aspect_Ratio_pooled, Group_name, 'Notch','on');
xticklabel_rotate((1:2),45,{{'Neg2'},{'MCAK2'}}, 'Interpreter', 'none')
title ('Aspect Ratio');

subplot (2, 3, 4) 
boxplot(Solidity_pooled, Group_name, 'Notch','on');
xticklabel_rotate((1:2),45,{{'Neg2'},{'MCAK2'}}, 'Interpreter', 'none')
title ('Solidity');
%%
print_save_figure(gcf, 'Fig3.Area_Eccentricity_AspectRatio_Solidity_Pooled', 'Processed');