function [y] = resample_audio (x, fs_old, fs_new, N)
    [L, M] = find_resample_step(fs_old, fs_new);
    
    b_i = fir1(N-1, 1/L,'low',chebwin(N));
    b_d = fir1(N-1, 1/M,'low',chebwin(N));
    
    x_i = interp(x, L);
    
    y_i = filter(b_i, 1, x_i);
    y_d = filter(b_d, 1, y_i);
    
    y = decimate(y_d, M);
end