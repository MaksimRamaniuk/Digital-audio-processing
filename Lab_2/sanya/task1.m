T = 5;
fs = 44100;
t = 0:1/fs:T;

f_start = 12000;
ampl = 6000;

f_size = 1024;
h_size = 256;

y = FM_sig(f_start, t, ampl, fs);

audiowrite('task1.wav', y, fs);

figure;
specgram(y, f_size, fs, hamming(f_size), f_size - h_size);
xlabel('Время (с)', 'FontName', 'Times New Roman', 'FontSize', 14);
ylabel('Частота (Гц)', 'FontName', 'Times New Roman', 'FontSize', 14);
title('Спектрограмма ЧМ-сигнала', 'FontName', 'Times New Roman', 'FontSize', 14);
set(gca, 'Clim', [-65 15]);
colorbar;	