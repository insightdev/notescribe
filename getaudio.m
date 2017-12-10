function [y,Fs,load] = getaudio

choice = questdlg('Load or new recording?', ...
    'Notescribe - select an option', ...
    'Load audio file', 'New Recording', 'New Recording');

if isempty(choice)
    y = [];
    Fs = 0;
    load = -1;
    return
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

    [y, Fs] = audioread(strcat(pathname,filename));
else
    Fs = 44100;
    rec = audiorecorder(Fs, 16, 1);
    seconds = inputdlg('How many seconds of audio?','Record');
    recordblocking(rec, str2double(seconds{1,1}));
    y = getaudiodata(rec);
end
