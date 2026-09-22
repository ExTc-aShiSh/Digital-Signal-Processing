% DSP Experiment: 4-Point DFT and IDFT via Matrix Formulation
clc; clear; close all;

% 1. Define 4-Point Input Sequence
x = [5, 7, 2, 8];                  % 4-sample sequence
N = 4;                             % Length N = 4
x = x(:);                          % Column vector (4 x 1)

% 2. Construct 4x4 Twiddle Factor Matrix
% W_N = exp(-j * 2 * pi / N)
n = 0:(N - 1);                     % Time indices: 0 to 3
k = 0:(N - 1);                     % Frequency indices: 0 to 3
nk = k' * n;                       % Outer product grid (4 x 4)

WN = exp(-1j * 2 * pi / N);        % Twiddle factor W_4 = -j
W_matrix = WN .^ nk;               % 4x4 Transformation Matrix

% 3. Matrix Multiplication: DFT and IDFT
% Forward DFT: X = W * x
X = W_matrix * x;

% Inverse DFT Matrix: W_inv = (1/N) * conj(W)
W_inv = (1 / N) * conj(W_matrix);
x_reconstructed = W_inv * X;

% Display Numerical Results in Command Window
disp('============== 4-POINT DFT & IDFT MATRIX METHOD ==============');
disp('Twiddle Matrix W_4:');
disp(round(W_matrix, 4));
disp('Input Sequence x[n]:');
disp(x.');
disp('Computed 4-point DFT X[k]:');
disp(X.');
disp('Reconstructed Sequence x_rec[n]:');
disp(real(x_reconstructed).');
disp('==============================================================');

% 4. Visualization: Input, Magnitude, and Phase Spectra
figure('Color', 'w', 'Position', [100, 100, 850, 650]);

% Input Signal Plot
subplot(3, 1, 1);
stem(n, x, 'filled', 'LineWidth', 1.5, 'Color', 'b');
title('Original 4-Point Input Signal x[n]');
xlabel('Sample Index (n)'); ylabel('Amplitude');
xticks(0:3); xlim([-0.5, 3.5]); grid on;

% DFT Magnitude Spectrum
subplot(3, 1, 2);
stem(k, abs(X), 'filled', 'LineWidth', 1.5, 'Color', 'r');
title('4-Point Magnitude Spectrum |X[k]|');
xlabel('Frequency Index (k)'); ylabel('Magnitude');
xticks(0:3); xlim([-0.5, 3.5]); grid on;

% DFT Phase Spectrum (with zero-thresholding)
phase_X = angle(X);
phase_X(abs(X) < 1e-10) = 0;

subplot(3, 1, 3);
stem(k, phase_X, 'filled', 'LineWidth', 1.5, 'Color', [0, 0.5, 0]);
title('4-Point Phase Spectrum \angle X[k] (radians)');
xlabel('Frequency Index (k)'); ylabel('Phase (rad)');
xticks(0:3); xlim([-0.5, 3.5]); grid on;