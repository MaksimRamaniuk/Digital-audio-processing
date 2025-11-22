load("var_5.mat")

N = length(x) + length(h) - 1;
x_new = [x, zeros(1, N -length(x))];
h_new = [h, zeros(1, N -length(h))];

y = zeros(1, N);
buf = zeros(1, N);
tmp = 0;

buf = fliplr(h_new);

for i= 1:N
    buf = [buf(end), buf(1:end-1)];
    
    tmp = sum(buf .* x_new);
    
    y(i) = tmp;
end

figure;
subplot(2,1,1);
plot(x);
xlabel('Samples', 'Interpreter', 'latex', 'FontSize', 14, 'FontName', 'Times New Roman');
ylabel('Amplitude', 'Interpreter', 'latex', 'FontSize', 14, 'FontName', 'Times New Roman');
title('Input signal', 'Interpreter', 'latex', 'FontSize', 14, 'FontName', 'Times New Roman');
xlim([0 length(x)]);grid on;
subplot(2,1,2);
plot(y);
xlabel('Samples', 'Interpreter', 'latex', 'FontSize', 14, 'FontName', 'Times New Roman');
ylabel('Amplitude', 'Interpreter', 'latex', 'FontSize', 14, 'FontName', 'Times New Roman');
title('Output signal', 'Interpreter', 'latex', 'FontSize', 14, 'FontName', 'Times New Roman');
xlim([0 length(y)]);grid on;