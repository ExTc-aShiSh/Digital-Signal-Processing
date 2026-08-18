% DSP Experiment: Linear vs Circular Convolution
clc; clear; close all;

% Input sequences
x1 = [9, 3, 8, 1];
x2 = [1, 7, 1, -9];

% 1. Linear Convolution
y_lin = conv(x1, x2);
L = length(x1) + length(x2) - 1; % Output length: N1 + N2 - 1

% 2. Circular Convolution (N-point, where N = max(N1, N2))
N = max(length(x1), length(x2));
y_circ = cconv(x1, x2, N);

% Display results in command window
disp('--- Convolution Results ---');
disp(['Sequence x1:            ', mat2str(x1)]);
disp(['Sequence x2:            ', mat2str(x2)]);
disp(['Linear Convolution:     ', mat2str(y_lin)]);
disp(['N-point Circular Conv:  ', mat2str(y_circ)]);

% 4. Visualization
figure('Color', 'w', 'Position', [100, 100, 800, 600]);

subplot(2, 2, 1);
stem(0:length(x1)-1, x1, 'filled', 'LineWidth', 1.5);
title('Sequence x_1[n]'); xlabel('n'); ylabel('Amplitude'); grid on;

subplot(2, 2, 2);
stem(0:length(x2)-1, x2, 'filled', 'LineWidth', 1.5);
title('Sequence x_2[n]'); xlabel('n'); ylabel('Amplitude'); grid on;

subplot(2, 2, 3);
stem(0:length(y_lin)-1, y_lin, 'filled', 'r', 'LineWidth', 1.5);
title(['Linear Conv (Length = ', num2str(L), ')']);
xlabel('n'); ylabel('Amplitude'); grid on;

subplot(2, 2, 4);
stem(0:N-1, y_circ, 'filled', 'b', 'LineWidth', 1.5);
title(['Circular Conv (N = ', num2str(N), ')']);
xlabel('n'); ylabel('Amplitude'); grid on;