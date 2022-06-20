% script to run model

function [sFile] = run_simbody_hand_20DOF(sDataPath,sModel,sFile_metaSegment,sFile_metaDOF,bReturn,tSim,sSubject,sSession,sMovementPath)
%% list of idDOFs for movement types are based on IDs in metaDOF
sMovementFolder = dir(sMovementPath);
sMovePath = [sMovementPath,filesep];
sPath = cd;

for iTrialType = 3:length(sMovementFolder)
sMetaTrialList(iTrialType-2,1)  = {sMovementFolder(iTrialType,1).name};
end

for iMovement = 1:length(sMetaTrialList)
sMoveFileName = string(sMetaTrialList(iMovement));
sNewName = char(erase(sMoveFileName,".csv"));
metaTrial         = load_csv('sPath',sMovePath,'sFile',sMoveFileName);

sDOFlist_move     = metaTrial.idDOF;
nRangelist_move   = metaTrial.nRangelist_move;

nIC_search = searchIC(metaTrial);

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

nIC_sim = setIC(nIC_search,nIC);

metaDOFsim.nIC                  = nIC_sim(~metaDOF.bLocked_simulink); % default DOF initial conditions

%% generate movement for each DOF
[nMoveRange] = setMoveRange(sDOFlist_move,nRangelist_move,nIC_sim);
nMoveRange(metaDOF.bLocked_simulink==1,:) = [];
% set simulation kinematics
% first 7 DOFs are unsued in Simulink model
nKin  = getIdealTrajectory(nRate,tSim,sDOFList,nMoveRange,bReturn);
clear pos vel acc
for iField = 1:nSignal
    pos.(sDOFList{iField}) = double(nKin.(sDOFList{iField})(:,1)');
    vel.(sDOFList{iField}) = double(nKin.(sDOFList{iField})(:,2)');
    acc.(sDOFList{iField}) = double(nKin.(sDOFList{iField})(:,3)');
end
pos.tTime = nKin.tTime;
vel.tTime = nKin.tTime;
acc.tTime = nKin.tTime;

% get model parameters and initialize
metaSegment = get_metaSegment('sFile',sFile_metaSegment);
save_csv(metaSegment,'sFile',[cd,filesep,'metaData',filesep,'_model_param.csv'])

% initialize model
ini_simbody(pos,vel,acc,metaSegment,metaDOFsim)

%   run inverse & forward simulations
%     hInv = Simulink.SimulationInput('RHand_20DOF_Inv_RU2.slx');
%

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
end

% sCSVpath = [sDataPath,filesep,'CSVs'];
% 
% try
%     cd(sCSVpath)
%     cd(sPath)
%     fillMetaData(sSubject,sSession,sDataPath)
% catch
% end