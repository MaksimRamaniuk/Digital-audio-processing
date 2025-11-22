load("filter_5.mat")
[x, fs] = audioread("test_signal.wav");

L = 2048;

M = length(h);
S = L + M - 1;
N_frames = floor(length(x) / L);
N_out = length(x) + length(h) - 1;

y_k = zeros(1, S);
mem = zeros(1, S);
x_k = zeros(1, L);
buf = zeros(1, S);
y = zeros(1, N_out);
h_new = [h, zeros(1, L-1)];

for i = 1:N_frames
    i_beg = (i - 1) * L + 1;
    i_end = (i - 1) * L + L;
    
    current_x = x(i_beg:i_end);
    if size(current_x, 1) > 1
        current_x = current_x';
    end
    x_k = [current_x, zeros(1, M - 1)];
    
    y_k = circ_conv(x_k, h_new);
    
    buf = [y_k(1:M-1) + mem(1:M-1), y_k(M:end)];
    
    mem = [y_k(L+1:end), zeros(1, max(0, M - length(y_k(L+1:end))))];
    
    y(i_beg:i_end) = buf(1:L);   
end

y(length(x) + 1: end) = mem(1:M-1);

y_conv = conv(x, h);

figure;
subplot(3,1,1);
specgram(x, 1024, fs, hamming(1024), 512);
xlabel('Время (с)', 'FontName', 'Times New Roman', 'FontSize', 14);
ylabel('Частота (Гц)', 'FontName', 'Times New Roman', 'FontSize', 14);
title('Спектрограмма исходного сигнала', 'FontName', 'Times New Roman', 'FontSize', 14);
set(gca, 'Clim', [-65 15]);
colorbar;
subplot(3,1,2);
specgram(y, 1024, fs, hamming(1024), 512);
xlabel('Время (с)', 'FontName', 'Times New Roman', 'FontSize', 14);
ylabel('Частота (Гц)', 'FontName', 'Times New Roman', 'FontSize', 14);
title('Спектрограмма y (перекрытие с суммированием)', 'FontName', 'Times New Roman', 'FontSize', 14);
set(gca, 'Clim', [-65 15]);
colorbar;
subplot(3,1,3);
specgram(y_conv, 1024, fs, hamming(1024), 512);
xlabel('Время (с)', 'FontName', 'Times New Roman', 'FontSize', 14);
ylabel('Частота (Гц)', 'FontName', 'Times New Roman', 'FontSize', 14);
title('Спектрограмма y\_conv (функция matlab)', 'FontName', 'Times New Roman', 'FontSize', 14);
set(gca, 'Clim', [-65 15]);
colorbar;