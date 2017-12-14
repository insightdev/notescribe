% Very naive stereo-to mono conversion, possibly lossy
% if the stereo channels contain different data. Doesn't really matter
% much for this purpose.
% Simply drops the second channel.
function [m] = lossymono(s)
% Inf holds the information about the size of the signal matrix.
inf = size(s);

% If the second cell (number of channels) is two
if inf(2) == 2
    % Select all rows in the first column (thus ignoring the second)
    m = s(:,1);
% Otherwise, do nothing - the signal is already mono, no need to convert.
else
    m = s;
end