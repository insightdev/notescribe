function [th] = calculate_threshold(sig, THRESHOLD_OFFSET)
above_zero = sig(abs(sig)>0);
average_volume = mean(abs(above_zero));
th = average_volume*THRESHOLD_OFFSET;