% script to run model

function [sFile] =  vid_simbody_hand_20DOF(sDataPath,sModel,sFile_metaSegment,sFile_metaDOF,bReturn,tSim,sMovementPath,tDelay,nRep)
%% list of idDOFs for movement types are based on IDs in metaDOF
sMovementFolder = dir(sMovementPath);
sMovePath = [sMovementPath,filesep];

if length(sMovementFolder) < 4
    sMovement = sMovementFolder(3).name;
    for iRep = 1:nRep
        sMetaTrialList(iRep,1) = {sMovement};
    end
    
else
    
    for iTrialType = 3:length(sMovementFolder)
        sMetaTrialList0(iTrialType-2,1)  = {sMovementFolder(iTrialType,1).name};
    end
    
    nRandOrder = randperm(length(sMetaTrialList0));
    sMetaTrialList = sMetaTrialList0(nRandOrder);
end

%% Iterate through each movement type in folder
for iMovement = 1:length(sMetaTrialList)
    sMoveFileName = string(sMetaTrialList(iMovement));
    sNewName = char(erase(sMoveFileName,".csv"));
    
    metaTrial.(sNewName)         = load_csv('sPath',sMovePath,'sFile',sMoveFileName);
    sDOFlist_move.(sNewName)     = metaTrial.(sNewName).idDOF;
    nRangelist_move.(sNewName)   = metaTrial.(sNewName).nRangelist_move;
    
    nIC_search.(sNewName) = searchIC(metaTrial.(sNewName));
    
    tVid                = tSim*length(sMetaTrialList);
    nRate               = 1000; % the number of samples in a trial
    
    %% create movement kinematics
    metaDOF         = load_csv('sFile',sFile_metaDOF);
    idDOF_list      = metaDOF.idDOF_simulink(~metaDOF.bLocked_simulink); % list of simulated idDOF
    nSignal         = numel(idDOF_list);
    
    metaDOFsim.sDOFList             = metaDOF.sDOF(~metaDOF.bLocked_simulink);
    metaDOFsim.idDOF_simulink       = metaDOF.idDOF_simulink(~metaDOF.bLocked_simulink); % default DOF initial conditions
    metaDOFsim.nViscosity           = metaDOF.nViscosity(~metaDOF.bLocked_simulink); % default DOF initial conditions
    metaDOFsim.nStiffness_spring    = metaDOF.nStiffness_spring(~metaDOF.bLocked_simulink); % default DOF initial conditions
    metaDOFsim.nAngle_spring_ref    = metaDOF.nAngle_spring_ref(~metaDOF.bLocked_simulink); % default DOF initial conditions
    metaDOFsim.nGravity             = 9.81; %Gravity, m/s^2
    metaDOFsim.nRangeMin            = metaDOF.nRangeMin(~metaDOF.bLocked_simulink); % DOF min angle
    metaDOFsim.nRangeMax            = metaDOF.nRangeMax(~metaDOF.bLocked_simulink); % DOF max angle
    sDOFList    = metaDOFsim.sDOFList ;
    nIC         = metaDOF.nIC;
    
    nIC_sim.(sNewName) = setIC(nIC_search.(sNewName),nIC);
    
    metaDOFsim.nIC.(sNewName)                  = nIC_sim.(sNewName)(~metaDOF.bLocked_simulink); % default DOF initial conditions
    
    %% generate movement for each DOF
    [nMoveRange.(sNewName)] = setBatchMoveRange(sDOFlist_move,nRangelist_move,nIC_sim,sNewName,sMetaTrialList);
    nMoveRange.(sNewName).(sNewName)(metaDOF.bLocked_simulink==1,:) = [];
    
    % set simulation kinematics
    % first 7 DOFs are unsued in Simulink model
    nKin0  = getBatchIdealTrajectory(nRate,sDOFList,nMoveRange,bReturn,tVid,sNewName,tSim,tDelay);
    nKin.(sNewName) = nKin0;
end

[pos,vel,acc] = setBatchKin(sMetaTrialList,nKin,nSignal,sDOFList,tDelay,nRate);

% get model parameters and initialize
metaSegment = get_metaSegment('sFile',sFile_metaSegment);
save_csv(metaSegment,'sFile',[cd,filesep,'metaData',filesep,'_model_param.csv'])

% initialize model
ini_simbody(pos,vel,acc,metaSegment,metaDOFsim)

tTimeInv = sim(sModel); % inverse simulation to get applied torques

clear tor
for iField = 1:nSignal
    tor.(sDOFList{iField}) = tor_sim.signals.values(:,metaDOFsim.idDOF_simulink(iField));
end
tor.tTime = tor_sim.time;
err = NaN;

%% save data
sFile = [sNewName,'.mat'];

outFile = avoidOverwrite(sFile,sDataPath);

sDataFile = [sDataPath,filesep,'sim_data',filesep,outFile];
mkdir([sDataPath,filesep,'sim_data'])
save(sDataFile,'pos','vel','acc','tor','err')

%% Save Video metaData
% sNewMetaTrialList = erase(sMetaTrialList,".csv");
% 
% sMetaDataPath = [sDataPath,filesep,'CSVs'];
% sMetaTrialType.sTrialType = sNewMetaTrialList;
% 
% sFileName = [sVideoFileName,'_TrialTypes.csv'];
% outFile = avoidOverwrite(sFileName,sMetaDataPath);
% 
% save_csv(sMetaTrialType,'sFile',outFile,'sPath',sMetaDataPath);

