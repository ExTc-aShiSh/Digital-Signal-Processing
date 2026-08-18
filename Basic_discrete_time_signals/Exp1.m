%% EXPERIMENT: Generation and Classification of Discrete-Time Signals
% Aim:
% Generate basic discrete-time signals:
% Unit Impulse, Unit Step, Ramp, Sinusoidal and Exponential
% and classify them as:
% 1. Periodic / Non-periodic
% 2. Even / Odd / Neither
% 3. Energy / Power signal

clc;
clear;
close all;

%% Define the Discrete-Time Index
n = -10:10;

%% Generate Basic Discrete-Time Signals

% 1. Unit Impulse Signal
% delta[n] = 1 for n = 0, otherwise 0
x_impulse = (n == 0);

% 2. Unit Step Signal
% u[n] = 1 for n >= 0, otherwise 0
x_step = (n >= 0);

% 3. Unit Ramp Signal
% r[n] = n for n >= 0, otherwise 0
x_ramp = n .* (n >= 0);

% 4. Sinusoidal Signal
% x[n] = sin(0.25*pi*n)
x_sine = sin(0.25*pi*n);

% 5. Exponential Signal
% x[n] = (0.8)^n
% For practical plotting, n is restricted to positive values
x_exp = (0.8).^n;


%% Plot Individual Signals

figure('Name','Individual Discrete-Time Signals','NumberTitle','off');

% Unit Impulse
subplot(3,2,1);
stem(n, x_impulse, 'filled', 'LineWidth', 1.2);
grid on;
xlabel('n');
ylabel('\delta[n]');
title('Unit Impulse Signal');

% Unit Step
subplot(3,2,2);
stem(n, x_step, 'filled', 'LineWidth', 1.2);
grid on;
xlabel('n');
ylabel('u[n]');
title('Unit Step Signal');

% Unit Ramp
subplot(3,2,3);
stem(n, x_ramp, 'filled', 'LineWidth', 1.2);
grid on;
xlabel('n');
ylabel('r[n]');
title('Unit Ramp Signal');

% Sinusoidal
subplot(3,2,4);
stem(n, x_sine, 'filled', 'LineWidth', 1.2);
grid on;
xlabel('n');
ylabel('x[n]');
title('Sinusoidal Signal');

% Exponential
subplot(3,2,5);
stem(n, x_exp, 'filled', 'LineWidth', 1.2);
grid on;
xlabel('n');
ylabel('x[n]');
title('Exponential Signal');


%% Combined Plot of All Signals

figure('Name','Combined Discrete-Time Signals','NumberTitle','off');

hold on;

% Different colors for different signals
stem(n, x_impulse, 'filled', ...
    'Color', 'r', 'LineWidth', 1.5, ...
    'DisplayName', 'Unit Impulse');

stem(n, x_step, 'filled', ...
    'Color', 'b', 'LineWidth', 1.2, ...
    'DisplayName', 'Unit Step');

stem(n, x_ramp, 'filled', ...
    'Color', 'g', 'LineWidth', 1.2, ...
    'DisplayName', 'Ramp');

stem(n, x_sine, 'filled', ...
    'Color', 'm', 'LineWidth', 1.2, ...
    'DisplayName', 'Sinusoidal');

stem(n, x_exp, 'filled', ...
    'Color', 'c', 'LineWidth', 1.2, ...
    'DisplayName', 'Exponential');

grid on;
xlabel('Discrete-Time Index (n)');
ylabel('Amplitude');
title('Combined Plot of Discrete-Time Signals');
legend('Location','best');
hold off;


%% Classification of Signals

disp(' ');
disp('==============================================');
disp(' CLASSIFICATION OF DISCRETE-TIME SIGNALS');
disp('==============================================');

%% Unit Impulse Classification

disp(' ');
disp('1. UNIT IMPULSE SIGNAL');
disp('   Periodic: No');
disp('   Symmetry: Even');
disp('   Classification: Energy Signal');

% Energy of unit impulse
E_impulse = sum(abs(x_impulse).^2);

fprintf('   Energy = %.2f\n', E_impulse);
fprintf('   Average Power = 0\n');


%% Unit Step Classification

disp(' ');
disp('2. UNIT STEP SIGNAL');
disp('   Periodic: No');
disp('   Symmetry: Neither Even nor Odd');
disp('   Classification: Power Signal');

% Approximate power over the selected range
P_step = mean(abs(x_step).^2);

fprintf('   Approximate Power = %.2f\n', P_step);


%% Ramp Classification

disp(' ');
disp('3. UNIT RAMP SIGNAL');
disp('   Periodic: No');
disp('   Symmetry: Neither Even nor Odd');
disp('   Classification: Neither Energy nor Power Signal');

% The ramp has infinite energy and infinite average power.


%% Sinusoidal Classification

disp(' ');
disp('4. SINUSOIDAL SIGNAL');
disp('   Signal: sin(0.25*pi*n)');
disp('   Periodic: Yes');
disp('   Fundamental Period: 8 samples');
disp('   Symmetry: Odd');
disp('   Classification: Power Signal');

% Average power of sinusoids with amplitude 1
P_sine = 0.5;

fprintf('   Average Power = %.2f\n', P_sine);


%% Exponential Classification

disp(' ');
disp('5. EXPONENTIAL SIGNAL');
disp('   Signal: (0.8)^n');
disp('   Periodic: No');
disp('   Symmetry: Neither Even nor Odd');
disp('   Classification: Energy Signal');

% Energy of a causal exponential x[n] = a^n u[n]
a = 0.8;
E_exp = 1 / (1 - a^2);

fprintf('   Energy = %.4f\n', E_exp);
fprintf('   Average Power = 0\n');


%% Final Classification Table

disp(' ');
disp('==============================================');
disp(' FINAL CLASSIFICATION');
disp('==============================================');

fprintf('\n');
fprintf('%-18s %-15s %-15s %-15s\n', ...
    'Signal', 'Periodicity', 'Symmetry', 'Type');
fprintf('---------------------------------------------------------------\n');

fprintf('%-18s %-15s %-15s %-15s\n', ...
    'Unit Impulse', 'Non-periodic', 'Even', 'Energy');

fprintf('%-18s %-15s %-15s %-15s\n', ...
    'Unit Step', 'Non-periodic', 'Neither', 'Power');

fprintf('%-18s %-15s %-15s %-15s\n', ...
    'Unit Ramp', 'Non-periodic', 'Neither', 'Neither');

fprintf('%-18s %-15s %-15s %-15s\n', ...
    'Sinusoidal', 'Periodic', 'Odd', 'Power');

fprintf('%-18s %-15s %-15s %-15s\n', ...
    'Exponential', 'Non-periodic', 'Neither', 'Energy');

disp(' ');
disp('Experiment completed successfully.');