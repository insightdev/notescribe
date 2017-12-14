% The main program for Notescribe.

% Clear any previously stored data
clear

% Load constants from configuration file
[...
LO, HI, TOLERANCE, ...
FRACTION, ...
THRESHOLD_MULTIPLIER ...
] = notescribe_config;

% Declare & preallocate variables
detected_freqs = zeros(1,1);
notes = strings(1);

try
    % Call the getaudio function
    % Either record, or load from an existing file
    % Returns a signal vector and sampling frequency
    [y,Fs] = getaudio;
    
    % Calculate the total number of samples 
    N = length(y);

    % Split the audio into pieces, each a fraction of a second
    % Fraction is determined by the configured constant that is loaded
    % at the start of the program.
    pieces = splitaudio(y, Fs, FRACTION);
    
    % The total number of pieces is the second output of size()
    [~, npieces] = size(pieces);
    
    % Calculate a threshold value for creating a new note
    % Explained further in the threshold calculation function
    threshold = calculate_threshold(pieces, THRESHOLD_MULTIPLIER);
    
    % Set the position to 1 (first detected frequency)
    pos = 1;
    
    % Iterate through the pieces of the signal
    for i = 1:npieces  
        % Select the full column of data
        piece = pieces(:,i);
        
        % If the average amplitude of the signal is above the threshold
        if mean(abs(piece)) > threshold
            % Calculate the fft, frequency range, and step of the piece
            [fft_v, freq_range, freq_step] = execute_fft(piece, N, Fs);
            
            % Shorten the fft vector to only include the 'useful range'
            % specified by the LO (low) and HI (high) constants
            [short_v, short_r] = shorten_fft(fft_v, freq_range, ...
                                                LO, HI, ...
                                                freq_step);
            
            % The index of the most prominent frequency in the piece
            [~, idx] = max(short_v);
            
            % The actual frequency, converted to an integer
            % Does not matter if the conversion is lossy (double to
            % int), as there's a certain frequency range.
            main_freq = uint64(short_r(idx));

            % If there are no elements in detected_freqs
            if detected_freqs(length(detected_freqs)) == 0
                % Insert the main_frequency at the first position
                detected_freqs(pos) = main_freq;
                pos = pos+1;
            % If the detected frequency in the previous piece is different
            % from the detected frequency in the current piece, add the
            % current detected frequency to the matrix.
            elseif detected_freqs(pos-1) ~= main_freq
                detected_freqs(pos) = main_freq;
                pos = pos+1;
            end
            
            % Otherwise, do nothing and move on to the next piece.
        end
    end
    
    % Clean up memory
    % remove indexing variables
    clear i pos idx N;
    % remove fft info
    clear fft_v freq_range freq_step fft_r short_r short_v main_freq;
    % remove cut up audio info
    clear piece pieces npieces;

    % Iterate through the detected frequencies
    for i = 1:length(detected_freqs)
        % Classify the detected frequency as a note, with a certain
        % tolerance to the frequency range, specified by the constant
        % from the config file.
        note = classify_note(detected_freqs(i), TOLERANCE);
        
        % If a note was detected
        if ~isempty(note)
            % If this is the first note, add it
            if notes(1) == ""
                notes(1) = note;
            % Otherwise, if the previously detected note is not the same
            % as the current detected note, append it to the matrix.
            elseif notes(length(notes)) ~= note
                notes(length(notes)+1) = note;
            end        
        end 
    end

    % Clean up memory
    clear note i;
    
    % If no notes were detected, display a message
    if notes == ""
        msgbox(...
            'No notes found', ...
            'Nothing');
    % Otherwise, list the detected notes
    else
        waitfor(msgbox(...
            {'Notes found:' ...
                sprintf('\n%s', notes{:}) ...
            }, ...
            'Success!'));
    end
    
    cleardata = questdlg(...
        'Would you like to clear the audio data?', ...
        'Clear data?', ...
        'Yes', 'No',...
        'Yes');
    
    % If they click yes, save to a file
    % If they do anything else, don't save to a file
    switch cleardata
        case 'Yes'
            clear y Fs;
    end
catch ME
    % If an error occurs, display the error and erase all variables
    % to prevent subsequent errors next time the program runs.
    waitfor(msgbox({ME.identifier;ME.message;},'Error'));
    clear
end