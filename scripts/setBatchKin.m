function [pos,vel,acc] = setBatchKin(sMetaTrialList,nKin,nSignal,sDOFList,tDelay,nRate)

%% 
sMoveFileList = string(sMetaTrialList);
sNewList = erase(sMoveFileList,".csv");
nSampleDelay = tDelay * nRate; % time between each movement rep

%% Clear Kinematic Variables
clear pos vel acc 
for i = 1:nSignal
    pos.(sDOFList{i}) = [];
    vel.(sDOFList{i}) = [];
    acc.(sDOFList{i}) = [];
end

%% iterate through kinematic data for each DOF
for iMovement = 1:length(sMoveFileList) 
    for iField = 1:nSignal
        pos0.(sDOFList{iField}) = [nKin.(string(sNewList(iMovement))).(sDOFList{iField})(:,1)];
        vel0.(sDOFList{iField}) = [nKin.(string(sNewList(iMovement))).(sDOFList{iField})(:,2)];
        acc0.(sDOFList{iField}) = [nKin.(string(sNewList(iMovement))).(sDOFList{iField})(:,3)];
        
        nDelayPos0.(sDOFList{iField})(1:nSampleDelay) = pos0.(sDOFList{iField})(1);
        nDelayVel0.(sDOFList{iField})(1:nSampleDelay) = single(0);
        nDelayAcc0.(sDOFList{iField})(1:nSampleDelay) = single(0);
        
        nDelayPos.(sDOFList{iField}) = nDelayPos0.(sDOFList{iField})';
        nDelayVel.(sDOFList{iField}) = nDelayVel0.(sDOFList{iField})';
        nDelayAcc.(sDOFList{iField}) = nDelayAcc0.(sDOFList{iField})';
        
        % Incorporating the delay between each rep
        pos.(sDOFList{iField}) = [pos.(sDOFList{iField}); nDelayPos.(sDOFList{iField}); pos0.(sDOFList{iField})];
        vel.(sDOFList{iField}) = [vel.(sDOFList{iField}); nDelayVel.(sDOFList{iField}); vel0.(sDOFList{iField})];
        acc.(sDOFList{iField}) = [acc.(sDOFList{iField}); nDelayAcc.(sDOFList{iField}); acc0.(sDOFList{iField})];
    end
end
     
sDOFList = string(sDOFList);
for i = 1:length(sDOFList)
    pos.(sDOFList(i)) = double(pos.(sDOFList(i)))';
    vel.(sDOFList(i)) = double(vel.(sDOFList(i)))';
    acc.(sDOFList(i)) = double(acc.(sDOFList(i)))';
end

%% Define time variable
pos.tTime = nKin.(sNewList(1)).tTime;
vel.tTime = nKin.(sNewList(1)).tTime;
acc.tTime = nKin.(sNewList(1)).tTime;
