clc;
fsize = 128;         
overlap = fsize / 2;    
step = fsize - overlap;
wa = hann(fsize, 'periodic');  
ws = hamming(fsize, 'periodic'); 
alpha = 1.5;             
noise_level = 0.1;       

[x, fs] = audioread('test_signal.wav');
N = length(x);

noise = noise_level * randn(size(x));
x_noisy = x + noise;

nFrames = floor((N - overlap) / step);
frames = zeros(fsize, nFrames);

for i = 1:nFrames
    startIdx = (i-1)*step + 1;
    frames(:, i) = x_noisy(startIdx:startIdx+fsize-1) .* wa;
end

processed_frames = zeros(size(frames));

for i = 1:nFrames
    frame = frames(:, i);
    C = dct(frame);           

    sigma = median(abs(C)) / 0.6745 + eps;
    threshold = alpha * sigma * sqrt(2*log(fsize));

    C_thr = sign(C) .* max(abs(C) - threshold, 0);

    frame_rec = idct(C_thr);

    processed_frames(:, i) = frame_rec .* ws;
end

y = zeros(N, 1);
win_norm = zeros(N, 1);

for i = 1:nFrames
    startIdx = (i-1)*step + 1;
    y(startIdx:startIdx+fsize-1) = y(startIdx:startIdx+fsize-1) + processed_frames(:, i);
    win_norm(startIdx:startIdx+fsize-1) = win_norm(startIdx:startIdx+fsize-1) + ws;
end

nz = win_norm > 1e-8;
y(nz) = y(nz) ./ win_norm(nz);

y = y / max(abs(y)) * 0.99;

SNR_noisy = 10*log10(sum(x.^2) / sum((x - x_noisy).^2));
SNR_denoised = 10*log10(sum(x.^2) / sum((x - y).^2));

fprintf('SNR зашумлённого сигнала: %.2f dB\n', SNR_noisy);
fprintf('SNR после обработки: %.2f dB\n', SNR_denoised);

audiowrite('denoised_dct.wav', y, fs);

t = (0:N-1)/fs;
figure;
subplot(3,1,1);
plot(t, x); title('Исходный сигнал'); xlabel('Время, с'); ylabel('Амплитуда');
grid on;
subplot(3,1,2);
plot(t, x_noisy); title(sprintf('Зашумлённый сигнал'));
xlabel('Время, с'); ylabel('Амплитуда'); grid on;
subplot(3,1,3);
plot(t, y); title(sprintf('Обработанный сигнал'));
xlabel('Время, с'); ylabel('Амплитуда'); grid on;

figure;
subplot(3,1,1);
spectrogram(x, hann(512), 256, 1024, fs, 'yaxis');
title('Исходный сигнал'); colorbar;

subplot(3,1,2);
spectrogram(x_noisy, hann(512), 256, 1024, fs, 'yaxis');
title('Зашумлённый сигнал'); colorbar;

subplot(3,1,3);
spectrogram(y, hann(512), 256, 1024, fs, 'yaxis');
title('После динамического шумоподавления (DCT)'); colorbar;
