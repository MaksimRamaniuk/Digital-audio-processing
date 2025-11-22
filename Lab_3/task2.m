load("var_5.mat")

y = circ_conv(x, h);
y_matlab = cconv(x, h, length(x));
error = y - y_matlab;

figure;
subplot(5,1,1);
plot(x);
xlabel('Samples', 'Interpreter', 'latex', 'FontSize', 14, 'FontName', 'Times New Roman');
ylabel('Amplitude', 'Interpreter', 'latex', 'FontSize', 14, 'FontName', 'Times New Roman');
title('Input signal', 'Interpreter', 'latex', 'FontSize', 14, 'FontName', 'Times New Roman');
xlim([0 length(x)]);grid on;
subplot(5,1,2);
plot(h);
xlabel('Samples', 'Interpreter', 'latex', 'FontSize', 14, 'FontName', 'Times New Roman');
ylabel('Amplitude', 'Interpreter', 'latex', 'FontSize', 14, 'FontName', 'Times New Roman');
title('Impulse response', 'Interpreter', 'latex', 'FontSize', 14, 'FontName', 'Times New Roman');
xlim([0 length(h)]);grid on;
subplot(5,1,3);
plot(y);
xlabel('Samples', 'Interpreter', 'latex', 'FontSize', 14, 'FontName', 'Times New Roman');
ylabel('Amplitude', 'Interpreter', 'latex', 'FontSize', 14, 'FontName', 'Times New Roman');
title('Output signal by circ conv', 'Interpreter', 'latex', 'FontSize', 14, 'FontName', 'Times New Roman');
xlim([0 length(y)]);grid on;
subplot(5,1,4);
plot(y_matlab);
xlabel('Samples', 'Interpreter', 'latex', 'FontSize', 14, 'FontName', 'Times New Roman');
ylabel('Amplitude', 'Interpreter', 'latex', 'FontSize', 14, 'FontName', 'Times New Roman');
title('Output signal by cconv', 'Interpreter', 'latex', 'FontSize', 14, 'FontName', 'Times New Roman');
xlim([0 length(y_matlab)]);grid on;
subplot(5,1,5);
plot(error, 'r');
xlabel('Samples', 'Interpreter', 'latex', 'FontSize', 14, 'FontName', 'Times New Roman');
ylabel('Amplitude', 'Interpreter', 'latex', 'FontSize', 14, 'FontName', 'Times New Roman');
title('Error', 'Interpreter', 'latex', 'FontSize', 14, 'FontName', 'Times New Roman');
xlim([0 length(error)]);grid on;