clc;
clear;
close all;

%% ============================================================
% EXPERIMENT:
% Compute DTFT of a discrete-time signal and verify
% Linearity, Time-Shifting and Frequency-Shifting properties
% =============================================================

%% 1. GIVEN DISCRETE-TIME SIGNAL

x = [5 6 9 8];          % Given signal
n = 0:length(x)-1;      % Time index

% Frequency range
w = linspace(-pi, pi, 1000);

%% ============================================================
% 2. COMPUTE DTFT OF ORIGINAL SIGNAL
% X(e^jw) = sum(x[n] * exp(-j*w*n))
% =============================================================

X = zeros(size(w));

for k = 1:length(w)
    X(k) = sum(x .* exp(-1j*w(k)*n));
end

%% ============================================================
% 3. PLOT ORIGINAL SIGNAL, MAGNITUDE AND PHASE SPECTRUM
% =============================================================

figure('Name','Original Signal and DTFT');

subplot(3,1,1);
stem(n, x, 'filled', 'LineWidth', 1.5);
grid on;
xlabel('n');
ylabel('x[n]');
title('Discrete-Time Signal x[n] = [5 6 9 8]');

subplot(3,1,2);
plot(w, abs(X), 'LineWidth', 1.5);
grid on;
xlabel('\omega (rad/sample)');
ylabel('|X(e^{j\omega})|');
title('Magnitude Spectrum of DTFT');

subplot(3,1,3);
plot(w, angle(X), 'LineWidth', 1.5);
grid on;
xlabel('\omega (rad/sample)');
ylabel('Phase (radians)');
title('Phase Spectrum of DTFT');


%% ============================================================
% 4. VERIFY LINEARITY PROPERTY
%
% a*x1[n] + b*x2[n]
% <---->
% a*X1(e^jw) + b*X2(e^jw)
% =============================================================

x1 = [5 6 9 8];
x2 = [2 4 6 8];

a = 2;
b = 3;

% Combined signal
y = a*x1 + b*x2;

% DTFT of x1
X1 = zeros(size(w));

for k = 1:length(w)
    X1(k) = sum(x1 .* exp(-1j*w(k)*n));
end

% DTFT of x2
X2 = zeros(size(w));

for k = 1:length(w)
    X2(k) = sum(x2 .* exp(-1j*w(k)*n));
end

% DTFT of combined signal
Y = zeros(size(w));

for k = 1:length(w)
    Y(k) = sum(y .* exp(-1j*w(k)*n));
end

% Expected result using linearity property
Y_expected = a*X1 + b*X2;

% Calculate error
error_linearity = max(abs(Y - Y_expected));

% Plot Linearity Verification
figure('Name','Linearity Property');

subplot(2,2,1);
plot(w, abs(Y), 'LineWidth', 1.5);
grid on;
xlabel('\omega (rad/sample)');
ylabel('Magnitude');
title('DTFT of a*x_1[n] + b*x_2[n]');

subplot(2,2,2);
plot(w, angle(Y), 'LineWidth', 1.5);
grid on;
xlabel('\omega (rad/sample)');
ylabel('Phase (radians)');
title('Phase Spectrum of DTFT of combineds signal');

subplot(2,2,3);
plot(w, abs(Y_expected), '--', 'LineWidth', 1.5);
grid on;
xlabel('\omega (rad/sample)');
ylabel('Magnitude');
title('aX_1(e^{j\omega}) + bX_2(e^{j\omega})');

subplot(2,2,4);
plot(w, angle(Y_expected),'--', 'LineWidth', 1.5);
grid on;
xlabel('\omega (rad/sample)');
ylabel('Phase (radians)');
title('Phase Spectrum of sum of DTFTs of signals');


%% ============================================================
% 5. VERIFY TIME-SHIFTING PROPERTY
%
% x[n-n0]
% <---->
% X(e^jw)*exp(-j*w*n0)
% =============================================================

n0 = 2;

% Delayed signal
x_shifted = [zeros(1,n0) x];

% New time index
n_shifted = 0:length(x_shifted)-1;

% DTFT of delayed signal
X_shifted = zeros(size(w));

for k = 1:length(w)
    X_shifted(k) = sum(x_shifted .* ...
        exp(-1j*w(k)*n_shifted));
end

% Expected DTFT using time-shifting property
X_expected_shift = X .* exp(-1j*w*n0);

% Calculate error
error_time_shift = max(abs(X_shifted - X_expected_shift));

% Plot Time-Shifting Verification
figure('Name','Time-Shifting Property');

subplot(2,2,1);
plot(w, abs(X_shifted), 'LineWidth', 1.5);
grid on;
xlabel('\omega (rad/sample)');
ylabel('Magnitude');
title('Magnitude of DTFT of Delayed Signal');

subplot(2,2,3);
plot(w, abs(X_expected_shift), '--', 'LineWidth', 1.5);
grid on;
xlabel('\omega (rad/sample)');
ylabel('Magnitude');
title('Expected Spectrum Using Time-Shifting Property');

subplot(2,2,2);
plot(w, angle(X_shifted), 'LineWidth', 1.5);
grid on;
xlabel('\omega (rad/sample)');
ylabel('Phase (radians)');
title('Phase Spectrum of DTFT of Delayed Signal');

subplot(2,2,4);
plot(w, angle(X_expected_shift),'--','LineWidth', 1.5);
grid on;
xlabel('\omega (rad/sample)');
ylabel('Phase (radians)');
title('Expected Phase Spectrum of DTFT of Delayed Signal');

%% ============================================================
% 6. VERIFY FREQUENCY-SHIFTING PROPERTY
%
% x[n]*exp(j*w0*n)
% <---->
% X(e^(j(w-w0)))
% =============================================================

w0 = pi/4;

% Frequency-shifted signal
x_freq_shift = x .* exp(1j*w0*n);

% DTFT of frequency-shifted signal
X_freq_shift = zeros(size(w));

for k = 1:length(w)
    X_freq_shift(k) = sum(x_freq_shift .* ...
        exp(-1j*w(k)*n));
end

% Expected frequency-shifted DTFT
X_expected_freq = zeros(size(w));

for k = 1:length(w)
    X_expected_freq(k) = sum(x .* ...
        exp(-1j*(w(k)-w0)*n));
end

% Calculate error
error_freq_shift = max(abs(X_freq_shift - X_expected_freq));

% Plot Frequency-Shifting Verification
figure('Name','Frequency-Shifting Property');

subplot(2,2,1);
plot(w, abs(X_freq_shift), 'LineWidth', 1.5);
grid on;
xlabel('\omega (rad/sample)');
ylabel('Magnitude');
title('Magnitude Spectrum After Frequency Shifting');

subplot(2,2,3);
plot(w, abs(X_expected_freq), '--', 'LineWidth', 1.5);
grid on;
xlabel('\omega (rad/sample)');
ylabel('Magnitude');
title('Expected Spectrum Using Frequency-Shifting Property');

subplot(2,2,2);
plot(w, angle(X_freq_shift), 'LineWidth', 1.5);
grid on;
xlabel('\omega (rad/sample)');
ylabel('Magnitude');
title('Phase Spectrum After Frequency Shifting');

subplot(2,2,4);
plot(w, angle(X_expected_freq),'--', 'LineWidth', 1.5);
grid on;
xlabel('\omega (rad/sample)');
ylabel('Magnitude');
title('Expected Phase Spectrum After Frequency Shifting');

%% ============================================================
% 7. DISPLAY RESULTS
% =============================================================

fprintf('\n============================================\n');
fprintf('DTFT PROPERTY VERIFICATION RESULTS\n');
fprintf('============================================\n');

fprintf('Maximum Linearity Error       = %e\n', ...
    error_linearity);

fprintf('Maximum Time-Shifting Error   = %e\n', ...
    error_time_shift);

fprintf('Maximum Frequency-Shifting Error = %e\n', ...
    error_freq_shift);

fprintf('\nErrors close to zero verify the DTFT properties.\n');
fprintf('============================================\n');