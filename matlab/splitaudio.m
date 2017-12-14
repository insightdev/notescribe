function [audiocols] = splitaudio(signal, Fs, fraction)

N = length(signal);
counter = 1;
col = 1;
audiocols = [];

while (counter <= N)
    for n=1:(Fs*fraction)
        if (counter <= N)
            audiocols(n, col) = signal(counter);
            counter = counter+1;
        end
    end
    col = col+1;
end




