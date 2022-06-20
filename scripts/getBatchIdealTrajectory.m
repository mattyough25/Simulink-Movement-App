function [nKin] = getBatchIdealTrajectory(nRate,sAngList,nMoveRange,bReturn,tVid,sNewName,tSim,tDelay)

nSmpl       = nRate*tSim;
nSmplT      = nRate*tVid;
nSmplD      = nSmplT*(tDelay+1);

tTime   = [0:1:nSmplD-1]/nRate;
if bReturn
    nSmpl = floor(nSmpl/2);
end
% default sigmoidal trajectory with bell-shaped velocity profile
x       = [-nSmpl/2:nSmpl/2-1]'*2*pi/nSmpl;
z       = sech(x);
z       = (z-min(z))/(max(z)-min(z));
if bReturn
    z = [z;-z]; % negative velocity for return
end
ffkin   = cumsum(z);
ffkin   = ffkin/max(ffkin);


nAngMax = nMoveRange.(sNewName).(sNewName)(:,2);% movement amplitude in rad

if bReturn
    for iDOF = 1:numel(sAngList)
        if nAngMax(iDOF)~=0
            nRadFilt = ffkin*nAngMax(iDOF); % scale the sigmoid to max angle
            [nData] = splineKin(nRadFilt, nRate);
            nData(:,1) = nData(:,1) + nMoveRange.(sNewName).(sNewName)(iDOF,1); % add back IC
        else
            nData(:,1) = nMoveRange.(sNewName).(sNewName)(iDOF,1)*ones(length(x)*2,1);
            nData(:,2:3) = zeros(length(x)*2,2);
        end
        nKin.(sAngList{iDOF}) = nData;
    end
else
  for iDOF = 1:numel(sAngList)
        if nAngMax(iDOF)~=0
            nRadFilt = ffkin*nAngMax(iDOF); % scale the sigmoid to max angle
            [nData] = splineKin(nRadFilt, nRate);
            nData(:,1) = nData(:,1) + nMoveRange.(sNewName).(sNewName)(iDOF,1); % add back IC
        else
            nData(:,1) = nMoveRange.(sNewName).(sNewName)(iDOF,1)*ones(length(x),1);
            nData(:,2:3) = zeros(length(x),2);
        end
        nKin.(sAngList{iDOF}) = nData;
  end
end

nKin.tTime   = tTime;
