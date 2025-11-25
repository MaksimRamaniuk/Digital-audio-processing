clear; clc;

[x, fs] = audioread("test_signal.wav");
if size(x,2) > 1
    x = mean(x,2);
end

t = (0:length(x)-1)/fs;

% Параметры компрессора
threshold = -30;    % Порог компрессии (дБ)
ratio = 3;          % Степень компрессии (например, 3:1)
attack = 0.01;      % Время атаки (сек)
release = 0.1;      % Время восстановления (сек)

% Параметры экспоненциального детектора
alpha = 0.95;       % Коэффициент для быстрого нарастания (x?(n) ? p(n-1))
beta = 0.99;        % Коэффициент для медленного спада (x?(n) < p(n-1))

y = zeros(size(x));
gain = 1;
gain_smooth = zeros(size(x)); % Для хранения коэффициента усиления

% Инициализация переменных детектора
p_prev = mean(x(1:min(100, length(x))).^2);  % Начальное значение мощности

for n = 1:length(x)
    % Экспоненциальный среднеквадратичный детектор
    x_squared = x(n)^2;
    
    if x_squared >= p_prev
        p_current = alpha * p_prev + (1 - alpha) * x_squared;
    else
        p_current = beta * p_prev + (1 - beta) * x_squared;
    end
    
    p_prev = p_current;
    
    % Перевод мощности в дБ
    power_db = 10 * log10(p_current + eps);
    
    % Расчет коэффициента усиления для реверсивного компрессора
    if power_db > threshold
        % Компрессия: уменьшаем усиление для сигналов выше порога
        excess_db = power_db - threshold;
        target_gain_db = -excess_db * (1 - 1/ratio);
        target_gain = 10^(target_gain_db / 20);
    else
        % Сигнал ниже порога - без изменений
        target_gain = 1;
    end
    
    % Применение атаки/восстановления к коэффициенту усиления
    if target_gain < gain
        % Атака
        alpha_attack = exp(-1/(attack * fs));
        gain = alpha_attack * gain + (1 - alpha_attack) * target_gain;
    else
        % Восстановление
        alpha_release = exp(-1/(release * fs));
        gain = alpha_release * gain + (1 - alpha_release) * target_gain;
    end
    
    gain_smooth(n) = gain;
    
    % Применение коэффициента усиления
    y(n) = gain * x(n);
end

figure;

subplot(2,1,1)
plot(t, x);
title('Исходный сигнал');
grid on
xlabel('Время, с'); 
ylabel('Амплитуда');
xlim([0 t(end)]);     

subplot(2,1,2)
plot(t, y);
title('Сигнал после реверсивного компрессора');
grid on
xlabel('Время, с');
ylabel('Амплитуда');
xlim([0 t(end)]);     

audiowrite('compressed_signal.wav', y, fs);