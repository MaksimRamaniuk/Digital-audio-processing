function [y_circ] = circ_conv(x, h)
    N = length(x);
    if length(x) > length(h)
        h = [h, zeros(1, N - length(h))];
    else
        x = [x, zeros(1, N - length(x))];
        N = length(h);
    end
    
    y_circ = zeros(1, N);
    buf = zeros(1, N);
    tmp = 0;
    
    buf = fliplr(h);
    
    for i= 1:N
        buf = [buf(end), buf(1:end-1)];
        
        tmp = sum(buf .* x);
        
        y_circ(i) = tmp;
    end
end