clc
[x, fs] = audioread('test_signal.wav');
f_size = 128;

x_wh = whisper_effect(x, f_size, f_size*0.5);
audiowrite('whisper.wav', x_wh, fs);

figure;
subplot(2,2,1);
specgram(x, f_size, fs, hamming(f_size), f_size - 64);
set(gca, 'Clim', [-65 15]);
colorbar;
title('Оригинальный звук');
xlabel('Время (с)');
ylabel('Частота (Гц)');

subplot(2,2,2);
specgram(x_wh, f_size, fs, hamming(f_size), f_size - 64);
set(gca, 'Clim', [-65 15]);
colorbar;
title('Шепот с перекрытием');
xlabel('Время (с)');
ylabel('Частота (Гц)');

t = (0:length(x)-1)/fs;
t_wh = (0:length(x_wh)-1)/fs;
subplot(2,2,3);
plot(t, x, 'k');
title('Оригинальный звук');
xlabel('Время (с)');
ylabel('Амплитуда');
grid on;
xlim([0 max(t)]);

subplot(2,2,4);
plot(t_wh, x_wh, 'k');
title('Шепот с перекрытием');
xlabel('Время (с)');
ylabel('Амплитуда');
grid on;
xlim([0 max(t_wh)]);
