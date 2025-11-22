% Квантование гармонического сигнала

N1 = 5;
N2 = 10;
n = 1:200;

s = cos(2*pi*350.*n/10000 + pi/2) - cos(2*pi*45.*n/10000 - pi/4);

s_max = max(abs(s));
s_norm = s / s_max;

s_q1 = serial_adc(s_norm, N1);
s_q2 = serial_adc(s_norm, N2);

figure;
subplot(2,1,1)
hold on
stem(s_norm, 'b')
stairs(s_q1, 'r')
xlabel('Отсчёты');
ylabel('Амплитуда');
title('Квантовый сигнал - разрядность АЦП 5');
grid on;

subplot(2,1,2)
hold on
stem(s_norm, 'b')
stairs(s_q2, 'r')
xlabel('Отсчёты');
ylabel('Амплитуда');
title('Квантовый сигнал - разрядность АЦП 10');
grid on;

% Ошибка квантования

e1 = s_norm - s_q1;
e2 = s_norm - s_q2;

figure;
hold on
stairs(e1, 'b')
stairs(e2, 'r')
xlabel('Отсчёты');
ylabel('Ошибка');
title('Ошибки квантования');
grid on;