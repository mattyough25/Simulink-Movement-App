function fillMetaData(sKinFile,sSubject,sSession,sDataPath,bDelsys,bArray)

%% Define Paths

sPath     = cd;
sMetaPath = [sDataPath,filesep,'sim_data',filesep,'metaTables'];

%% Fill metaTrial
% Load metaTrial
sMetaTrial = load_csv('sPath',sMetaPath,'sFile','sim_metaTrial.csv');

nSize  = size(sMetaTrial.sFile);
nSize2 = size(sMetaTrial.sFile{1,1});

% Indexing for placement in metaData files
if nSize2(1) == 0
    ix = nSize(1) - 1;
else
    ix = nSize(1);
end

sMetaTrial.sFile{ix+1,1}        = sKinFile;
sMetaTrial.sPath{ix+1,1}        = [sDataPath,filesep,'sim_data'];
sMetaTrial.sTrialType{ix+1,1}   = erase(sKinFile,".mat");
sMetaTrial.sSubject{ix+1,1}     = sSubject;
sMetaTrial.sSession{ix+1,1}     = sSession;

if bDelsys
    sMetaTrial.nTrial(ix+1,1)           = ix+1;

    sMetaTrial.bSim(ix+1,1)             = 1;
    sMetaTrial.bLeap(ix+1,1)            = 1;
    sMetaTrial.bOculus(ix+1,1)          = 0;
    sMetaTrial.bEMG(ix+1,1)             = 1;
    sMetaTrial.bACC(ix+1,1)             = 1;
    sMetaTrial.bForce(ix+1,1)           = 0;
    sMetaTrial.bArray(ix+1,1)           = 0;
elseif bArray
    sMetaTrial.nTrial(ix+1,1)           = ix+9;

    sMetaTrial.bSim(ix+1,1)             = 1;
    sMetaTrial.bLeap(ix+1,1)            = 1;
    sMetaTrial.bOculus(ix+1,1)          = 0;
    sMetaTrial.bEMG(ix+1,1)             = 0;
    sMetaTrial.bACC(ix+1,1)             = 0;
    sMetaTrial.bForce(ix+1,1)           = 0;
    sMetaTrial.bArray(ix+1,1)           = 1;
end
sMetaTrial.bTrial(ix+1,1)       = 1;
sMetaTrial.tSync(ix+1,1)        = 0;
sMetaTrial.nGain(ix+1,1)        = 1;
sMetaTrial.nSampleStart(ix+1,1) = 1;
% sMetaTrial.sNote{ix+1}        = {''};
% sMetaTrial.idTrial{ix+1}      = {''};
% sMetaTrial.nSampleEnd(ix+1)   = {''};
    
save_csv(sMetaTrial,'sFile',[sMetaPath,filesep,'sim_metaTrial.csv'])
%% Fill metaTrialType
% Load metaTrialType
sMetaTrialType = load_csv('sPath',sMetaPath,'sFile','sim_metaTrialType.csv');

sMetaTrialType.idTrialType(ix+1,1)  = ix+1;
sMetaTrialType.sTrialType{ix+1,1}   = erase(sKinFile,".mat");
%sMetaTrialType.sNote{ix+1,1} = {''};

save_csv(sMetaTrialType,'sFile',[sMetaPath,filesep,'sim_metaTrialType.csv'])

cd(sPath);
