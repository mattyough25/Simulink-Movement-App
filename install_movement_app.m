function install_movement_app
clc

%% look for install_movement_app.m
sPath   = which('install_movement_app.m','-all');

%% Add target directories and save the updated path
ix                  = strfind(sPath{1},'\');

sPathDaqLocation    = sPath{1}(1:ix(end));

sPathList = [...
    sPathDaqLocation,   pathsep,...
    sPathDaqLocation,   'scripts',pathsep,...
    sPathDaqLocation,   'metaData',pathsep,...
    sPathDaqLocation,   'configFiles',pathsep,...
    sPathDaqLocation,   'model',pathsep,...
    sPathDaqLocation,   'movements',pathsep,...
    ];

addpath(sPathList);
fprintf(['\n-----------------------------------------------------\n',...
    'Simulink Movement App folders added to the path\n']);

result = savepath;
if result==1
    nl = char(10);
    msg = [' Unable to save updated MATLAB path '];
    error(msg);
else
    fprintf('Saved updated MATLAB path\n');
end

clear sPath ap result nl msg
