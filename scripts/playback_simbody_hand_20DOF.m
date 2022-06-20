function vidWindow = playback_simbody_hand_20DOF(sDataPath,sVideoFileName,tSimTime,nReps,nPause,ip,tPause)

sVideoPath = [sDataPath,filesep,'videos'];
sVideo = [sVideoPath,filesep,sVideoFileName];

vidWindow = implay(sVideo);
myControls = vidWindow.DataSource.Controls;

%% Movie Player Controller
bDF = questdlg('Would you like to connect to Dragonfly?');

switch bDF % Plays video and either sends data to Dragonfly ('Yes') or does not ('No')
    case 'Yes'
        
%% subscribe to DF messages
        % add messages
        MessageTypes =  {'SERVER_TIMESTAMP_USER'};
        % Messages to subscribe to DF
        ConnectArgs = {0, [], 'message_defs_wvu.mat'};
        mm_ip = ip;
        if strcmp(mm_ip, '[]')
            mm_ip = [];
        end
        if exist('mm_ip','var') && ~isempty(mm_ip)
            ConnectArgs{end+1} = ['-server_name ' mm_ip, ':7111'];
        end
        ConnectToMMM(ConnectArgs{:});
        Subscribe( MessageTypes{:});
        
        % Set countdown to video timer and play video
        for iPause = 1:nPause
            pause(1)
            Pause = nPause - iPause;
            disp(num2str(Pause))
        end
        play(myControls);
        genTimeStamps(sDataPath,sVideoFileName,tSimTime,nReps,tPause);
        
    case 'No'
        % Set countdown to video timer and play video
        for iPause = 1:nPause
            pause(1)
            Pause = nPause - iPause;
            disp(num2str(Pause))
        end
        play(myControls);
        
end