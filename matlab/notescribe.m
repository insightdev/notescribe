[y,Fs,load] = getaudio;

if load == -1
    disp('User cancelled.');
    return
elseif load == 0
    savefile = questdlg('Would you like to save the file?', ...
        'Save file?', ...
        'Yes', 'No', 'No');
    switch savefile
        case 'Yes'
            filename = inputdlg('What is the path?','Path');
            audiowrite(filename{1,1},y,Fs);
        case 'No'
            waitfor(msgbox('Not saving file','Save cancelled'));
    end 
end

monoy = simplesig2mono(y);
N = length(monoy)-1;

[fft_v, freq_range, freq_step] = execute_fft(monoy, N, Fs);

LO = 80;
HI = 1200;

[short_v, short_r] = shorten_fft(fft_v, freq_range, LO, HI, freq_step);
[~,idx] = max(short_v);
main_freq = uint64(short_r(idx))
msgbox(['The highest frequency is ' num2str(main_freq) ' Hz'], 'Result')

% Time to employ a rule-based classifier

%{

playable notes
low: 80 Hz
high: 1200 Hz


E	329.63 Hz	E4
B	246.94 Hz	B3
G	196.00 Hz	G3
D	146.83 Hz	D3
A	110.00 Hz	A2
E	82.41 Hz	E2
%}