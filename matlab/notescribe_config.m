function [LO, HI, ...
            TOLERANCE, FRACTION, ...
            THRESHOLD_MULTIPLIER] = notescribe_config()

% Lowest possible frequency (Hz)
LO = 80;

% Highest possible frequency (Hz)
HI = 650;

% Frequency bounds tolerance
% a good tolerance for a guitar is ±2.8 percent
TOLERANCE = 0.028;

% Split window (fraction of a second)
FRACTION = 1;

% Offset for the 'new note' threshold
THRESHOLD_MULTIPLIER = 1.5;