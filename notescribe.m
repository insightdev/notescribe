[y,Fs,load] = getaudio;

if load == -1
    disp('User cancelled.');
    return
elseif load == 0
    savefile = questdlg('Would you like to save the file?', ...
        'Save file?', ...
        'Yes', 'No', 'No');
    
    if isempty(savefile)
        disp('User cancelled.');
        return
    elseif savefile == 'Yes'
        filename = inputdlg('What is the path?','Path');
        audiowrite(filename{1,1},y,Fs);
    end
end

monoy = simplesig2mono(y);
