function genTimeStamps(sDataPath,sVideoFileName,tSimTime,nReps,tPause)

global DF % define dragonfly variable

%% Define File Names
sVideoFileName = erase(sVideoFileName, ".avi");
mkdir([sDataPath,filesep,'sim_data',filesep,'time_stamps'])
sFile = [sDataPath,filesep,'sim_data',filesep,'time_stamps',filesep,sVideoFileName,'_TimeServerTime.mat'];

%% Set timer and initialize index

% ix = 1;

%% read data from DF
EMG1           = ReadMessage(0);

%% read timeserver timestamp
% Request Time Server Time
nMT  = EnsureNumericMessageType('REQUEST_TIMESTAMP_USER');
% Get Sending Time
msg         = DF.MDF.REQUEST_TIMESTAMP_USER;
UnsafeSendMessage( nMT, msg);
SIM2           = ReadMessage('blocking');
tTime1 = SIM2.data.t;

if ~isempty(tTime1)
    tDFTime.SIM = tTime1;


%     ix = ix + 1; % re-compute index for each iteration
end

save(sFile,'tDFTime')

