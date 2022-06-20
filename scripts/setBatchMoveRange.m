function [nMoveRange] = setBatchMoveRange(idDOFlist_move,nRangelist_move,nIC,sNewName,sMetaTrialList)

nMoveAng                     = zeros(length(nIC.(sNewName)),1);
nMoveRange0                   = [nIC.(sNewName),nMoveAng];

%% Perform Movement
for iDOF = 1:numel(idDOFlist_move.(sNewName))
    nMoveRange0(idDOFlist_move.(sNewName)(iDOF),:) = [nIC.(sNewName)(idDOFlist_move.(sNewName)(iDOF)),nRangelist_move.(sNewName)(iDOF)]; % elbow at 0 deg   
end

for iTrial = 1:length(sMetaTrialList)
     nMoveRange.(sNewName) = nMoveRange0;
end
