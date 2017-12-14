% Record new audio, or load from an already existing file. Outputs mono.
function [y,Fs] = getaudio
% Set up an exception for the user cancelling a window
ME = MException(...
    'Notescribe:Getaudio:UserCancelled', ...
    'User cancelled');

% Ask the user whether they want to record or load a file
choice = questdlg(...
    'Load or new recording?', ...
    'Notescribe', ...
    'Load audio file', 'New Recording', ...
    'New Recording');

% If the user cancels/closes the window, throw the exception
if isempty(choice)
    throw(ME)
end

% Set a flag based on what the user clicked in the window
switch choice
    case 'Load audio file'
        load = 1;
    case 'New Recording'
        load = 0;
end

% If the user decided to load from a file
if load == 1
    % Let the user select an audio file
    [filename, pathname] = uigetfile( ...
    {
    '*.mp3;*.flac;*.aac;*.m4a;*.wav', ...
    'MATLAB Files (*.mp3;*.flac;*.aac;*.m4a;*.wav)';
    '*.mp3',  'MP3 Files (*.mp3)'; ...
    '*.flac','Lossless FLAC (*.flac)'; ...
    '*.aac','AAC (*.aac)';
    '*.m4a','MPEG-4 (*.m4a)';
    '*.wav','Lossless Wave (*.wav)'
    }, ... 
    'Pick an audio file');

    % If the user cancels, throw the exception
    if filename == 0
        throw(ME);
    end
    
    % Read from an audio file into an audio vector
    % Also store the sampling frequency
    [y, Fs] = audioread(strcat(pathname,filename));
    
    % Convert stereo audio to mono
    y = lossymono(y);
else
    % Set the sampling frequency
    % Default for musical instruments is 44.1 KHz
    Fs = 44100;
    
    % Set up a recorder object, 16-bit mono audio at 44.1 KHz
    rec = audiorecorder(Fs, 16, 1);
    
    % Ask the user for the duration of the recording
    seconds = inputdlg('How many seconds of audio?','Record');
    
    % If the user cancels, throw the exception
    if isempty(seconds)
        throw(ME);
    end
    
    % Let the user start the recording
    startrecord = questdlg(...
        sprintf(...
            'Press record to start recording (%s sec.)', ...
            seconds{1,1}), ...
        'Start', ...
        'Record', 'Cancel', ...
        'Record');
    
    % If the user cancels, throw the exception
    if startrecord ~= 'Record'
        throw(ME)
    end
    
    % Record for however many seconds the user entered
    recordblocking(rec, str2double(seconds{1,1}));
    
    % Place the data in the recorder object in a vector
    y = getaudiodata(rec);
    
    % Ask the user whether they want to save a the file
    savefile = questdlg(...
        'Would you like to save the file?', ...
        'Save file?', ...
        'Yes', 'No',...
        'No');
    
    % If they click yes, save to a file
    % If they do anything else, don't save to a file
    switch savefile
        case 'Yes'
            % If they click yes, ask them for the path
            filename = inputdlg('What is the path?','Path');
            
            % If there's no path, throw the exception
            if isempty(filename)
                throw(ME)
            % Otherwise, write the audio to a file
            else
                audiowrite(filename{1,1},y,Fs);
            end
    end 
end
