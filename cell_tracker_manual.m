% Manually track cell in migration.
% 1st code to use in matlab. 
% Pre-process: use the macro 'Tiff2ImgSequence' saved under /Applications/Fiji
% to save .tiff movies into as image sequences. 
% Then Go to each folder containing image sequences to run the code.

% HZ Jan 2017 Bloomington MATLAB R2016a

%%
clc; clear; 
folder_info = dir('*.tif');
folder_info = folder_info(arrayfun(@(x) x.name(1), folder_info) ~= '.');

%%
crd = [];
for i = 1:2:length(folder_info)
    img = imread(folder_info(i).name); 
    imshow(imresize(img,2), []); 
    folder_info(i).crd = ginput(1); 
end 
close;
%% save .mat contaiing crd 
save([folder_info(1).name(1:end-8), '.mat'], 'folder_info'); 