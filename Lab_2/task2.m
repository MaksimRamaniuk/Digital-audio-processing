clc
[x, fs] = audioread('test_signal.wav');
f_size = 128;

x_25 = whisper_effect(x, fs, f_size, f_size*0.25); % 25% перекрытие
audiowrite('whisper_25.wav', x_25, fs);

x_50 = whisper_effect(x, fs, f_size, f_size*0.5); % 50% перекрытие
audiowrite('whisper_50.wav', x_50, fs);

x_75 = whisper_effect(x, fs, f_size, f_size*0.75); % 75% перекрытие
audiowrite('whisper_75.wav', x_75, fs);

figure;
subplot(3,1,1);
specgram(x_25, f_size, fs, hamming(f_size), f_size - 64);
set(gca, 'Clim', [-65 15]);
colorbar;
title('Шепот с перекрытием 25%');
xlabel('Время (с)');
ylabel('Частота (Гц)');

subplot(3,1,2);
specgram(x_50, f_size, fs, hamming(f_size), f_size - 64);
set(gca, 'Clim', [-65 15]);
colorbar;
title('Шепот с перекрытием 50%');
xlabel('Время (с)');
ylabel('Частота (Гц)');

subplot(3,1,3);
specgram(x_75, f_size, fs, hamming(f_size), f_size - 64);
set(gca, 'Clim', [-65 15]);
colorbar;
title('Шепот с перекрытием 75%');
xlabel('Время (с)');
ylabel('Частота (Гц)');

t_25 = (0:length(x_25)-1)/fs;
t_50 = (0:length(x_50)-1)/fs;
t_75 = (0:length(x_75)-1)/fs;
figure;
subplot(3,1,1);
plot(t_25, x_25, 'k');
title('Шепот с перекрытием 25%');
xlabel('Время (с)');
ylabel('Амплитуда');
grid on;
xlim([0 max(t_25)]);

subplot(3,1,2);
plot(t_50, x_50, 'k');
title('Шепот с перекрытием 50%');
xlabel('Время (с)');
ylabel('Амплитуда');
grid on;
xlim([0 max(t_50)]);

subplot(3,1,3);
plot(t_75, x_75, 'k');
title('Шепот с перекрытием 75%');
xlabel('Время (с)');
ylabel('Амплитуда');
grid on;
xlim([0 max(t_75)]);