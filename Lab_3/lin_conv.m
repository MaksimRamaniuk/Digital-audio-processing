function [y_lin] = lin_conv(x, h)
    N = length(x) + length(h) - 1;
    x_new = [x, zeros(1, N -length(x))];
    h_new = [h, zeros(1, N -length(h))];
    
    y_lin = zeros(1, N);
    buf = zeros(1, N);
    tmp = 0;
    
    for i= 1:N
        buf = [h_new(i), buf(1:end-1)];
        
        tmp = sum(buf .* x_new);
        
        y_lin(i) = tmp;
    end
end