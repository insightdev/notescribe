function [fft_v, freq_range] = shorten_fft(v, x, low, high, step)

low_end = floor(low/step);
high_end = ceil(high/step);

intlo = uint64(low_end);
inthi = uint64(high_end);

if intlo ~= low_end || inthi ~= high_end
    throw MException('Error in integer conversion.')
end

fft_v = v(intlo:inthi);
freq_range = x(intlo:inthi);