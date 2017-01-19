% Track cell on migration.
% HZ Jan 2017 Bloomington MATLAB R2016a

% Go to each folder containing image sequences 
clc; clear; 
folder_info = dir('*.tif');
folder_info = folder_info(arrayfun(@(x) x.name(1), folder_info) ~= '.');

%%
crd = [];
for i = 1:2:length(folder_info)
    img = imread(folder_info(i).name); 
    imshow(img, []); 
    folder_info(i).crd = ginput(1); 
end 
close;
%% save .mat contaiing crd 
save([folder_info(1).name(1:end-12), '.mat'], 'folder_info'); 