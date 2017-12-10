function [fft_v, freq_range, freq_step] = execute_fft(signal, N, Fs)

freq_step = Fs/N;

fft_v = abs(fft(signal, N));
fft_v = fft_v(1:uint64(N/2));

freq_range = (0:(N/2)-1)*freq_step;
