% Shorten an FFT vector and range to a 'useful' range of frequencies.
function [fft_v, freq_range] = shorten_fft(v, x, low, high, step)

% Round the low/high end frequencies down and up respectively
low_end = floor(low/step);
high_end = ceil(high/step);

% Convert to an integer
intlo = uint64(low_end);
inthi = uint64(high_end);

% If the converted and original values are different, there was a
% conversion error. Shouldn't happen but who knows.
if intlo ~= low_end || inthi ~= high_end
    throw MException('Error in integer conversion.')
end

% Return the FFT vector and frequency range, shorted only to the
% necessary frequencies.
fft_v = v(intlo:inthi);
freq_range = x(intlo:inthi);