[y,Fs,load] = getaudio;

if load == 0
    savefile = questdlg('Would you like to save the file?', ...
        'Save file?', ...
        'Yes', 'No', 'No');
    
    switch savefile
        case 'Yes'
            filename = inputdlg('What is the path?','Path');
            audiowrite(filename{1,1},y,Fs);
        case 'No'
    end
end