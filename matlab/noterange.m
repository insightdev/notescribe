% Create a lower or upper bound for a given frequency
% based on a preconfigured tolerance.
function [bound] = noterange(hl, freq, tol)

switch hl
    case 0
        bound = freq-(tol*freq);
    case 1
        bound = freq+(tol*freq);
end