% Fourier transform a signal, returning the vector and the range/step.
function [fft_v, freq_range, freq_step] = execute_fft(signal, N, Fs)

% Calculate the frequency step
% Using the total number of samples because we still have to consider
% the full signal, even though we are only transforming a segment.
freq_step = Fs/N;

% Take the absolute value of the FFT of the signal
% since the imaginary parts are unnecessary.
fft_v = abs(fft(signal, N));

% Only take the first half of the matrix
fft_v = fft_v(1:uint64(length(fft_v)/2));

% Create a frequency range (x-axis)
freq_range = (0:(N/2)-1)*freq_step;
