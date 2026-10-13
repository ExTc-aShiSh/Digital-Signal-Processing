clc;
clear;
close all;

%% Experiment: Radix-2 DIT FFT and Direct DFT Comparison

% Define the input signal
x = [1 5 4 6 2 1 7 5];    
 
N = length(x);

% Radix-2 DIT FFT requires N to be a power of 2
if 2^nextpow2(N) ~= N
    error('Input signal length must be a power of 2.');
end

n = 0:N-1;
k = 0:N-1;

%% 1. Direct DFT Computation

X_DFT = zeros(1, N);

for k1 = 0:N-1
    for n1 = 0:N-1
        X_DFT(k1+1) = X_DFT(k1+1) + ...
            x(n1+1) * exp(-1j*2*pi*k1*n1/N);
    end
end

%% 2. Radix-2 DIT FFT Implementation

% Bit-reversal permutation
numBits = log2(N);
indices = zeros(1, N);
 
for i = 0:N-1
    value = i;
    reversed = 0;

    for j = 1:numBits
        reversed = 2*reversed + mod(value, 2);
        value = floor(value/2);
    end

    indices(i+1) = reversed + 1;
end

% Rearrange input samples in bit-reversed order
X_FFT = x(indices);

% Iterative butterfly computation
for stage = 1:numBits

    L = 2^stage;
    halfL = L/2;

    % Twiddle factors for this stage
    W = exp(-1j*2*pi*(0:halfL-1)/L);

    for start = 1:L:N

        for m = 0:halfL-1

            evenIndex = start + m;
            oddIndex = start + m + halfL;

            evenValue = X_FFT(evenIndex);
            oddValue = X_FFT(oddIndex) * W(m+1);

            % Butterfly operations
            X_FFT(evenIndex) = evenValue + oddValue;
            X_FFT(oddIndex) = evenValue - oddValue;

        end
    end
end

%% 3. Compare DFT and FFT Results

Magnitude_DFT = abs(X_DFT);
Magnitude_FFT = abs(X_FFT);

Phase_DFT = angle(X_DFT);
Phase_FFT = angle(X_FFT);

% Numerical error between the two methods
Error = abs(X_DFT - X_FFT);

fprintf('\n===== DFT and DIT-FFT Comparison =====\n');

fprintf('\nInput Signal:\n');
disp(x);

fprintf('Direct DFT Output:\n');
disp(X_DFT);

fprintf('Radix-2 DIT FFT Output:\n');
disp(X_FFT);

fprintf('Absolute Error at Each Frequency Bin:\n');
disp(Error);

fprintf('Maximum Absolute Error = %.12e\n', max(Error));

%% 4. Visualization

figure('Name', 'Radix-2 DIT FFT Experiment', ...
       'NumberTitle', 'off');

% Input signal
subplot(2,2,1);
stem(n, x, 'filled', 'LineWidth', 1.2);
grid on;
xlabel('Sample Index (n)');
ylabel('Amplitude');
title('Input Discrete-Time Signal');

% Magnitude spectrum comparison
subplot(2,2,2);
stem(k, Magnitude_DFT, 'b', 'filled', ...
    'LineWidth', 1.2);
hold on;
stem(k, Magnitude_FFT, 'r--', ...
    'LineWidth', 1.2);
grid on;
xlabel('Frequency Index (k)');
ylabel('Magnitude');
title('Magnitude Spectrum: DFT vs DIT-FFT');
legend('Direct DFT', 'Radix-2 DIT FFT');

% Phase spectrum comparison
subplot(2,2,3);
stem(k, Phase_DFT, 'b', 'filled', ...
    'LineWidth', 1.2);
hold on;
stem(k, Phase_FFT, 'r--', ...
    'LineWidth', 1.2);
grid on;
xlabel('Frequency Index (k)');
ylabel('Phase (radians)');
title('Phase Spectrum: DFT vs DIT-FFT');
legend('Direct DFT', 'Radix-2 DIT FFT');

% Absolute error
subplot(2,2,4);
stem(k, Error, 'filled', 'LineWidth', 1.2);
grid on;
xlabel('Frequency Index (k)');
ylabel('Absolute Error');
title('Absolute Error Between DFT and FFT');

sgtitle('Radix-2 Decimation-in-Time FFT Analysis');


%% 5. Radix-2 DIT FFT Butterfly Diagram

figure('Name', 'Radix-2 DIT FFT Butterfly Diagram', ...
       'NumberTitle', 'off', ...
       'Color', 'w');

hold on;
axis off;

numStages = log2(N);

% Bit-reversed input
data = x(indices);

% Store intermediate values
stageData = zeros(N, numStages + 1);
stageData(:,1) = data(:);

% Calculate values at each FFT stage
for stage = 1:numStages

    L = 2^stage;
    halfL = L/2;

    W = exp(-1j*2*pi*(0:halfL-1)/L);

    for start = 1:L:N
        for m = 0:halfL-1

            upper = start + m;
            lower = start + m + halfL;

            a = data(upper);
            b = data(lower) * W(m+1);

            data(upper) = a + b;
            data(lower) = a - b;

        end
    end

    stageData(:,stage+1) = data(:);
end

% Node positions
xPos = 1:numStages+1;
yPos = N:-1:1;

%% Draw connections between stages

for stage = 1:numStages

    L = 2^stage;
    halfL = L/2;

    for start = 1:L:N
        for m = 0:halfL-1

            upper = start + m;
            lower = start + m + halfL;

            % Straight upper-to-upper connection
            plot([xPos(stage), xPos(stage+1)], ...
                 [yPos(upper), yPos(upper)], ...
                 'b-', 'LineWidth', 1.2);

            % Straight lower-to-lower connection
            plot([xPos(stage), xPos(stage+1)], ...
                 [yPos(lower), yPos(lower)], ...
                 'b-', 'LineWidth', 1.2);

            % Upper-to-lower connection
            plot([xPos(stage), xPos(stage+1)], ...
                 [yPos(upper), yPos(lower)], ...
                 'r--', 'LineWidth', 1.2);

            % Lower-to-upper connection
            plot([xPos(stage), xPos(stage+1)], ...
                 [yPos(lower), yPos(upper)], ...
                 'g--', 'LineWidth', 1.2);

        end
    end
end

%% Display intermediate complex values

for stage = 1:numStages+1
    for i = 1:N

        val = stageData(i,stage);

        label = sprintf('%.2f%+.2fj', ...
                        real(val), imag(val));

        text(xPos(stage), yPos(i), label, ...
             'HorizontalAlignment', 'center', ...
             'VerticalAlignment', 'middle', ...
             'FontSize', 8, ...
             'BackgroundColor', 'w');
    end
end

%% Stage labels

stageLabels = {'Bit-Reversed Input', ...
               'Stage 1', 'Stage 2', 'Stage 3'};

for stage = 1:numStages+1

    text(xPos(stage), N+0.8, stageLabels{stage}, ...
         'HorizontalAlignment', 'center', ...
         'FontWeight', 'bold', ...
         'FontSize', 10);
end

%% Formatting

title('Radix-2 DIT FFT Butterfly Diagram', ...
      'FontSize', 13);

legend({'Upper-to-upper', 'Lower-to-lower', ...
        'Upper-to-lower', 'Lower-to-upper'}, ...
        'Location', 'southoutside', ...
        'Orientation', 'horizontal');

xlim([0.5, numStages+1.5]);
ylim([0, N+1.5]);

hold off;