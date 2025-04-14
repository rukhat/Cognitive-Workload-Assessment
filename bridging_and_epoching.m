clc;
clear;
close all;

eeglab_path = fileparts(which('/eeglab/eeglab.m'));
[ALLEEG EEG CURRENTSET ALLCOM] = eeglab;

files = dir('../dataset/sub-02/ses-S1/eeg/*BACK.set');

for i=1:length(files)
    folder_name = files(i).folder;
    file_name = files(i).name;
    file_path = append(folder_name, '/', file_name);
    disp(file_path)
    
    remove_channels = {'ECG1'};
    EEG = pop_loadset(file_path);
    EEG = pop_select(EEG, 'nochannel', remove_channels);

    EB = eBridge(EEG, 'PlotModer', 0, 'Verbose', 0);
    bridged_chanlocs = EB.Bridged.Indices

    interpolated_EEG = pop_interp(EEG, bridged_chanlocs, 'spherical');
    EB_interpolated = eBridge(interpolated_EEG, 'PlotModer', 0, 'Verbose', 0);
   
    epoched_EEG = pop_epoch(interpolated_EEG, [-0.25 1.75])
    epoched_EEG = pop_saveset(epoched_EEG, append('/home/ncl-pc2/COG-BCI Project/epoch_data/N-Back/sub-02/S1_epoched_', file_name))
end


% % 

% % 


% file_path = '../dataset/sub-01/ses-S1/eeg/zeroBACK.set';


% 

% % folder_name = files(1).folder;
% % file_name = files(2).name;
% % 
% % file_path = append(folder_name, '/', file_name);
% % 



% features = extractCSPFeatures(epoched_EEG, )
% 
% filename = '../dataset/sub-01/ses-S1/eeg/MATBmed.set';
% conditions = {'standard'};
% remove_channels = ['ECG1'];
% 
% EEG = pop_loadset(filename);
% 
% EB = eBridge(EEG);
% 
% disp(files)