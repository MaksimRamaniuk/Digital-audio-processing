function [y_sin] = FM_sig(f_start, t, amp, fs)
    T = t(end);
    fun = sinc(t - T/2); 
    frc = amp .* fun + f_start;
    phase_cumsum = cumsum(frc) / fs;
    y_sin = sin(2 * pi * phase_cumsum);
end