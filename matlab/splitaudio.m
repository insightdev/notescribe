% This function splits an audio signal into multiple parts.
% Each part is stored in one column in the audiocols matrix
function [audiocols] = splitaudio(signal, Fs, fraction)

% Get the total number of samples in the signal
N = length(signal);

% Initialise indexing variables
counter = 1;
col = 1;

% Initialise the result variable
audiocols = [];

% Iterate through the signal.
% The result is a matrix with columns corresponding to FRACTION of a
% second. So if the recording was 4 seconds long, and FRACTION is set
% to 1, there will be 4 columns in the final matrix, each with Fs rows.
while (counter <= N)
    % From 1 to the sampling frequency times the fraction of a second
    % (basically 1 to the number of samples in a given fraction)
    for n=1:(Fs*fraction)
        % If there are elements to add
        if (counter <= N)
            % Place the element in a cell in the current column
            audiocols(n, col) = signal(counter);
            % Increment the counter
            counter = counter+1;
        end
    end
    % Once the number of samples in the fraction of the second has been
    % reached, move to the next column.
    col = col+1;
end




