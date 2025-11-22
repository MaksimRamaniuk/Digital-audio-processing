function [s_q] = serial_adc(x, N)
    for n = 1:length(x)
        rpp = 0;
        data = x(n);
        
        for i = 1:N
            rpp = rpp + 2^(-i);
            if(abs(data) < rpp)
                rpp = rpp - 2^(-i); 
            end            
        end
        
        s_q(n) = sign(data) * rpp;
    end
end