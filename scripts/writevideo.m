function [sVideoFile] = writevideo(sModelName,sDataPath,sVideoFileName,nPlaybackSpeedRatio)

%% Define video name and output path
sVideoPath = [sDataPath,filesep,'videos'];
sVideoName = [sVideoFileName,'.avi'];
sVideoFile = [sVideoPath,filesep,sVideoName];

sNewName = erase(sModelName,".slx");

%% Change current directory to video output path
try
   cd(sVideoPath)
catch % dir ~exist => make new dir
   cd(sDataPath)
   mkdir('videos')
   cd(sVideoPath)
end

%% Write video
outFile = avoidOverwrite(sVideoName,sVideoPath);

smwritevideo(sNewName,outFile,'PlaybackSpeedRatio', nPlaybackSpeedRatio)