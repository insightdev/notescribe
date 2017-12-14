function [m] = lossymono(s)
inf = size(s)
if inf(2) == 2
    m = s(:,1);
end