% Configuration file to set the necessary constants.
function [LO, HI, TOLERANCE, ...
            FRACTION, ...
            THRESHOLD_MULTIPLIER] = notescribe_config()

% Lowest possible frequency (Hz) - different for every instrument
LO = 80;

% Highest possible frequency (Hz) - different for every instrument
HI = 650;

% Frequency bounds tolerance
% a good tolerance for a guitar is ±2.8 percent (based on bounds)
TOLERANCE = 0.028;

% Audio segment window (fraction of a second)
% 1 works well, but it can be recalibrated as needed
FRACTION = 1;

% Offset for the 'new note' threshold
THRESHOLD_MULTIPLIER = 1.5;