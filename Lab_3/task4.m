load("var_5.mat")

N = length(x) + length(h) - 1;
x_new = [x, zeros(1, N -length(x))];
h_new = [h, zeros(1, N -length(h))];

y = zeros(1, N);
x_fft = fft(x_new);
h_fft = fft(h_new);
y = ifft(x_fft .* h_fft);

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