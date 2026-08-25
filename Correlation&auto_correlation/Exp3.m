% DSP Experiment: Auto-Correlation, Cross-Correlation, and Symmetry Analysis
clc; clear; close all;

% 1. Define Input Sequences
x = [1, 2, 3, 4];          % First sequence
y = [2, 1, 0, 3];          % Second sequence

Nx = length(x);
Ny = length(y);

% 2. Auto-Correlation: Rxx(l)
% Using xcorr with raw (unnormalized) scale
[Rxx, lags_auto] = xcorr(x);

% 3. Cross-Correlation: Rxy(l) and Ryx(l)
[Rxy, lags_cross] = xcorr(x, y);
[Ryx, ~]          = xcorr(y, x);

% 4. Symmetry & Energy Verification
E_x = sum(abs(x).^2);                  % Total energy of x[n]
Rxx_zero_lag = Rxx(lags_auto == 0);     % Rxx at lag l = 0

% Check auto-correlation even symmetry: Rxx[l] == Rxx[-l]
is_auto_even = isequal(Rxx, fliplr(Rxx));

% Check cross-correlation conjugate/folding property: Rxy[l] == Ryx[-l]
is_cross_symmetric = isequal(Rxy, fliplr(Ryx));

% Display Numerical Results in Command Window
disp('================ Correlation Results ================');
disp(['Sequence x[n]:            ', mat2str(x)]);
disp(['Sequence y[n]:            ', mat2str(y)]);
disp('-----------------------------------------------------');
disp(['Auto-correlation Rxx[l]:  ', mat2str(Rxx)]);
disp(['Cross-correlation Rxy[l]: ', mat2str(Rxy)]);
disp(['Cross-correlation Ryx[l]: ', mat2str(Ryx)]);
disp('-----------------------------------------------------');
disp(['Total Signal Energy E_x:  ', num2str(E_x)]);
disp(['Auto-corr at Lag 0 Rxx(0):', num2str(Rxx_zero_lag)]);
disp(['Rxx(0) == Energy E_x?     ', mat2str(Rxx_zero_lag == E_x)]);
disp(['Is Rxx[l] Even Symmetric? ', mat2str(is_auto_even)]);
disp(['Is Rxy[l] == Ryx[-l]?     ', mat2str(is_cross_symmetric)]);
disp('=====================================================');

% 5. Visualization
figure('Color', 'w', 'Position', [100, 100, 900, 700]);

% Plot input signals
subplot(3, 2, 1);
stem(0:Nx-1, x, 'filled', 'LineWidth', 1.5);
title('Input Signal x[n]'); xlabel('n'); ylabel('Amplitude'); grid on;

subplot(3, 2, 2);
stem(0:Ny-1, y, 'filled', 'LineWidth', 1.5);
title('Input Signal y[n]'); xlabel('n'); ylabel('Amplitude'); grid on;

% Plot auto-correlation
subplot(3, 2, [3, 4]);
stem(lags_auto, Rxx, 'filled', 'r', 'LineWidth', 1.5);
title('Auto-Correlation R_{xx}[l] (Even Symmetry: R_{xx}[l] = R_{xx}[-l])');
xlabel('Lag (l)'); ylabel('Amplitude'); grid on;

% Plot cross-correlations
subplot(3, 2, 5);
stem(lags_cross, Rxy, 'filled', 'b', 'LineWidth', 1.5);
title('Cross-Correlation R_{xy}[l]');
xlabel('Lag (l)'); ylabel('Amplitude'); grid on;

subplot(3, 2, 6);
stem(lags_cross, Ryx, 'filled', 'm', 'LineWidth', 1.5);
title('Cross-Correlation R_{yx}[l] (Note: R_{xy}[l] = R_{yx}[-l])');
xlabel('Lag (l)'); ylabel('Amplitude'); grid on;