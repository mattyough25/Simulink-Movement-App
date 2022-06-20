function saveConfig(sconfigFileName,sSubject,sSession,sSex,sDOB,nHeight,nWeight,sSegmentParameters,sDOF,sDataPath,sMovementPath,sModelName,tSim,sVideoFileName,nPlaybackSpeedRatio,nReturnMovements,tDelay,nPause,nRep,bMetaFill)

%% Save the app GUI configuration
sFile = ['configFiles',filesep,sconfigFileName,'.mat'];
save(sFile,'sSubject','sSession','sSex','sDOB','nHeight','nWeight','sSegmentParameters','sDOF','sDataPath','sMovementPath','sModelName','tSim','sVideoFileName','nPlaybackSpeedRatio','nReturnMovements','tDelay','nPause','nRep','bMetaFill')
