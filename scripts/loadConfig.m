function app = loadConfig(sFileName)

%% Load app Config File
app = load(['configFiles',filesep,sFileName,'.mat']); 