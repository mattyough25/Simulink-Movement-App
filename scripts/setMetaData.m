function [] = setMetaData(sDataPath,sSubjectNumber,sSessionNumber,sSex,sDOB,nHeight,nWeight,sHand,sTitle,bMed)

%% Creates directory for subject metaData
sPath = cd;
sMetaDataPath = [sDataPath,filesep,'sim_data',filesep,'metaTables'];

[~, ~, ~] = mkdir(sMetaDataPath);

cd(sMetaDataPath)

%% metaSubject
% Convert units to metric
nHeight = str2num(nHeight)*0.0254;
nWeight = str2num(nWeight)*0.453592;

% Calculate age in years
sCurrentDate = datestr(now,'yyyy/mm/dd');
nAge = year(datenum(sCurrentDate) - datenum(sDOB));

metaSubject.sSubject = {sSubjectNumber};
metaSubject.sPrefix = {sSubjectNumber};
metaSubject.sSession = {sSessionNumber};
metaSubject.sSex = {sSex};
metaSubject.nAge = {nAge};
metaSubject.sTitle = {sTitle};
metaSubject.sNote = {''};
metaSubject.sDOB = {sDOB};
metaSubject.nHeight = {nHeight};
metaSubject.nWeight = {nWeight};
metaSubject.sHand = {sHand};
if bMed
    metaSubject.bMed_AD = {1};
else
    metaSubject.bMed_AD = {0};
end

save_csv(metaSubject,'sFile','sim_metaSubject.csv')

%% metaSignal 
sNameList = {'ra_wr_s_p','ra_wr_e_f','ra_cmc1_ad_ab','ra_cmc1_f_e','ra_mcp1_f_e',...
    'ra_ip1_f_e','ra_mcp2_e_f','ra_pip2_e_f','ra_dip2_e_f','ra_mcp3_e_f','ra_pip3_e_f',...
    'ra_dip3_e_f','ra_mcp4_e_f','ra_pip4_e_f','ra_dip4_e_f','ra_mcp5_e_f','ra_pip5_e_f',...
    'ra_dip5_e_f','ra_el_e_f','ra_wr_ad_ab','tTime'}';
metaSignal.sSignalRaw = [sNameList;sNameList;sNameList;sNameList];
sTable_pos(1:21)    = {'pos'};
sTable_pos(22:42)   = {'vel'};
sTable_pos(43:63)   = {'acc'};
sTable_pos(64:84)   = {'tor'};
metaSignal.sTable = sTable_pos';

metaSignal.sSignal  = metaSignal.sSignalRaw;
metaSignal.nSignal  = [1:84]';
metaSignal.nRate    = 1000*ones(84,1);

sUnit(1:21)    = {'rad'};
sUnit(22:42)   = {'rad/s'};
sUnit(43:63)   = {'rad/s^2'};
sUnit(64:84)   = {'Nm'};
metaSignal.sUnit = sUnit';

save_csv(metaSignal,'sFile','sim_metaSignal.csv')
%% metaTrial
metaTrial.sFile = {''};
metaTrial.sPath = {''};
metaTrial.sTrialType = {''};
metaTrial.sSubject = {''};
metaTrial.sSession = {''};
metaTrial.nTrial = {''};
metaTrial.bTrial = {''};
metaTrial.tSync = {''};
metaTrial.nGain = {''};
metaTrial.nSampleStart = {''};
metaTrial.sNote = {''};
metaTrial.idTrial = {''};
metaTrial.nSampleEnd = {''};

save_csv(metaTrial,'sFile','sim_metaTrial.csv');

%% metaTrialType
metaTrialType.idTrialType = {''};
metaTrialType.sTrialType = {''};
metaTrialType.sNote = {''};

save_csv(metaTrialType,'sFile','sim_metaTrialType.csv');
cd(sPath)