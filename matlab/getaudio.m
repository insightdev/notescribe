function [y,Fs] = getaudio
ME = MException('Notescribe:Getaudio:UserCancelled', ...
        'User cancelled');
    
choice = questdlg('Load or new recording?', ...
    'Notescribe - select an option', ...
    'Load audio file', 'New Recording', 'New Recording');

if isempty(choice)
    throw(ME)
end

switch choice
    case 'Load audio file'
        load = 1;
    case 'New Recording'
        load = 0;
end

if load == 1
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

    if filename == 0
        throw(ME);
    end
    [y, Fs] = audioread(strcat(pathname,filename));
else
    Fs = 44100;
    rec = audiorecorder(Fs, 16, 1);
    seconds = inputdlg('How many seconds of audio?','Record');
    
    if isempty(seconds)
        throw(ME);
    end
    
    startrecord = questdlg(...
        sprintf('Press record to start recording (%s sec.)', seconds{1,1}), ...
        'Start', ...
        'Record', 'Cancel', 'Record');
    
    if startrecord ~= 'Record'
        throw(ME)
    end
    
    recordblocking(rec, str2double(seconds{1,1}));
    y = getaudiodata(rec);
    
    savefile = questdlg('Would you like to save the file?', ...
        'Save file?', ...
        'Yes', 'No', 'No');
    switch savefile
        case 'Yes'
            filename = inputdlg('What is the path?','Path');
            
            if isempty(filename)
                throw(ME)
            else
                audiowrite(filename{1,1},y,Fs);
            end
    end 
end
