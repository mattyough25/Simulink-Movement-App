function [nMoveRange] = setMoveRange(idDOFlist_move,nRangelist_move,nIC)

nMoveAng                     = zeros(length(nIC),1);
nMoveRange                   = [nIC,nMoveAng];

%% Perform Movement
for iDOF = 1:numel(idDOFlist_move)
    nMoveRange(idDOFlist_move(iDOF),:) = [nIC(idDOFlist_move(iDOF)),nRangelist_move(iDOF)]; % elbow at 0 deg   
end
x=1;