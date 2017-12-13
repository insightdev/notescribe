clear

% load constants from config file
[LO, HI, TOLERANCE, FRACTION, THRESHOLD_MULTIPLIER] = notescribe_config;

% declare variables
detected_freqs = [];
notes = strings(1);

try
    [y,Fs] = getaudio;

    monoy = lossymono(y);
    N = length(monoy)-1;

    pieces = splitaudio(monoy, Fs, FRACTION);
    [~, npieces] = size(pieces);
    
    threshold = calculate_threshold(pieces, THRESHOLD_MULTIPLIER);
    
    pos = 1;
    for i = 1:npieces
        piece = pieces(:,i);
        if mean(abs(piece)) > threshold
            [fft_v, freq_range, freq_step] = execute_fft(piece, N, Fs);
            [short_v, short_r] = shorten_fft(fft_v, freq_range, ...
                                                LO, HI, freq_step);
            [~,idx] = max(short_v);
            main_freq = uint64(short_r(idx));

            if isempty(detected_freqs)
                detected_freqs(pos) = main_freq;
                pos = pos+1;
            elseif detected_freqs(pos-1) ~= main_freq
                detected_freqs(pos) = main_freq;
                pos = pos+1;
            end
        end
    end
    
    % Clean up memory
    clear i pos idx;            %remove iterator vars
    clear y Fs N;               %remove original signal info
                                %remove fft info
    clear fft_v freq_range freq_step fft_r short_r short_v main_freq;
    clear piece pieces npieces; %remove cut up audio info

    for i = 1:length(detected_freqs)
        note = classify_note(detected_freqs(i),TOLERANCE);
        if ~isempty(note)
            if notes(1) == ""
                notes(1) = note;
            elseif notes(length(notes)) ~= note
                notes(length(notes)+1) = note;
            end        
        end 
    end

    % clean up memory
    clear note i;
    
    if notes==""
        msgbox('No notes found', 'Nothing');
    else
        msgbox({'Notes found:' sprintf('\n%s',notes{:})},...
            'Success!');
    end
catch ME
    waitfor(msgbox({ME.identifier;ME.message;},'Error'));
    clear
end