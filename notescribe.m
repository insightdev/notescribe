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
N = length(monoy)-1;

[fft_v, freq_range, freq_step] = execute_fft(monoy, N, Fs);

LO = 80;
HI = 1200;

[short_v, short_r] = shorten_fft(fft_v, freq_range, LO, HI, freq_step);
