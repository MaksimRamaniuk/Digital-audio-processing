[x, fs] = audioread('test_signal.wav');
N = length(x);
t = (0:N-1)/fs;

f_start = 300;    
f_end   = 800;  
f_step  = 30;     
dt     = 512;    

freqs = f_start:f_step:f_end;
numFreqs = length(freqs);

modulator = zeros(size(x));

for n = 1:N
    freqIndex = floor((n-1)/dt);
    currentFreq = freqs(mod(freqIndex, numFreqs) + 1);

    modulator(n) = sin(2*pi*currentFreq*t(n));
end

x_mod = x .* modulator;
x_mod = x_mod / max(abs(x_mod)) * 0.99;

audiowrite('ring_modulated.wav', x_mod, fs);

figure;
subplot(2,2,1);
plot(t, x);
title('Исходный сигнал');
xlabel('Время, с'); ylabel('Амплитуда');
grid on;
subplot(2,2,2);
plot(t, x_mod);
title('Обработанный сигнал (кольцевая циклическая модуляция)');
xlabel('Время, с'); ylabel('Амплитуда');
grid on;

subplot(2,2,3);
spectrogram(x, 1024, 512, 1024, fs, 'yaxis');
title('Спектрограмма исходного сигнала');
colormap('jet');
subplot(2,2,4);
spectrogram(x_mod, 1024, 512, 1024, fs, 'yaxis');
title('Спектрограмма обработанного сигнала');
colormap('jet');