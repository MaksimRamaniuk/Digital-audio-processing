% Расчёт антиалайзинговых фильтров для децимации и интерполяции

n = 1000;
[L, M] = find_resample_step(44100, 48000);
b_d = fir1(n-1, 1/M,'low',chebwin(n));
b_i = fir1(n-1, 1/L,'low',chebwin(n));

figure;
freqz(b_d,1); %АЧХ и ФЧХ
grid on;
figure;
freqz(b_i,1); %АЧХ и ФЧХ
grid on;

% Преобразование частоты дискретизации аудиосигнала

[x, fs_old] = audioread('ML70_06.wav');
fs_new = 14000;

y = resample_audio(x, fs_old, fs_new, n);

audiowrite('new_aud.wav', y, fs_new);

% Построение временного и частотно-временного (спектрограмма) представления исходного и модифицированного аудиосигналов
figure;
subplot(2,2,1);
t_old = (0:length(x)-1) / fs_old;
plot(t_old, x);
title('Исходный аудиосигнал');
xlabel('Время, с');
ylabel('Амплитуда');
grid on;

subplot(2,2,2);
t_new = (0:length(y)-1) / fs_new;
plot(t_new, y);
title('Модифицированный аудиосигнал');
xlabel('Время, с');
ylabel('Амплитуда');
grid on;

subplot(2,2,3);
specgram(x, 512, fs_old, hann(512), 475);
set(gca,'Clim', [-65 15]);
xlabel('Время, с');
ylabel('Частота, гц');
title('Исходный аудиосигнал - частота дискретизации 8000');
colorbar;
    
subplot(2,2,4);
specgram(y, 512, fs_new, hann(512), 475);
set(gca,'Clim', [-65 15]);
xlabel('Время, с');
ylabel('Частота, гц');
title('Модифицированный аудиосигнал - частота дискретизации 14000');
colorbar;