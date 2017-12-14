% This function calculates and returns a threshold value
% for a piece of the signal to constitute a 'new note'.
% It calculates value based on the signal and a certain threshold
% offset, configured in the config file.
% In the main file, the average amplitude of a segment of the signal
% is compared to the offset average amplitude of the whole signal, and if
% the average amplitude of the segment is higher, it means that the piece
% of the signal is a new note.
function [th] = calculate_threshold(sig, THRESHOLD_OFFSET)
% Select the samples whose absolute value is greater than zero.
above_zero = sig(abs(sig)>0);

% Calculate the average amplitude of those samples
average_volume = mean(abs(above_zero));

% Return the average amplitude, offset by a threshold multiplier
th = average_volume*THRESHOLD_OFFSET;