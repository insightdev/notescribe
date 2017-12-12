function [bound] = noterange(hl, freq, tol)

switch hl
    case 0
        bound = freq-(tol*freq);
    case 1
        bound = freq+(tol*freq);
end