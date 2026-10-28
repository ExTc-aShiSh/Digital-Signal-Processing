clc;
clear;
close all;

%% Experiment: Radix-2 DIF FFT and Efficiency Analysis

% Input signal
x = [7 1 8 4 5 9 8 6];
N = length(x);

% Check whether N is a power of 2
if N < 2 || 2^round(log2(N)) ~= N
    error('Input length must be a power of 2 and at least 2.');
end

n = 0:N-1;
k = 0:N-1;
M = log2(N);

%% 1. Direct DFT Computation

tic;

X_DFT = zeros(1,N);

for kk = 0:N-1
    for nn = 0:N-1
        X_DFT(kk+1) = X_DFT(kk+1) + ...
            x(nn+1)*exp(-1j*2*pi*kk*nn/N);
    end
end

time_DFT = toc;

%% 2. Radix-2 DIF FFT Implementation

tic;

X_DIF = x;

% Store values at each stage for the butterfly diagram
stageData = zeros(N,M+1);
stageData(:,1) = X_DIF(:);

for stage = 1:M

    L = N/2^(stage-1);
    halfL = L/2;

    W = exp(-1j*2*pi*(0:halfL-1)/L);

    for start = 1:L:N

        for m = 0:halfL-1

            upper = start + m;
            lower = start + m + halfL;

            a = X_DIF(upper);
            b = X_DIF(lower);

            % DIF butterfly operations
            X_DIF(upper) = a + b;
            X_DIF(lower) = (a - b)*W(m+1);

        end
    end

    stageData(:,stage+1) = X_DIF(:);
end

% DIF produces output in bit-reversed order.
% Rearrange it into natural frequency order.
indices = zeros(1,N);

for i = 0:N-1
    value = i;
    reversed = 0;

    for j = 1:M
        reversed = 2*reversed + mod(value,2);
        value = floor(value/2);
    end

    indices(i+1) = reversed + 1;
end

X_DIF = X_DIF(indices);

time_DIF = toc;

%% 3. Numerical Comparison

Error = abs(X_DFT - X_DIF);

fprintf('\n===== DFT vs Radix-2 DIF FFT =====\n');

fprintf('\nInput signal:\n');
disp(x);

fprintf('Direct DFT output:\n');
disp(X_DFT);

fprintf('Radix-2 DIF FFT output:\n');
disp(X_DIF);

fprintf('Absolute error at each frequency bin:\n');
disp(Error);

fprintf('Maximum absolute error = %.12e\n', max(Error));

%% 4. Computational Efficiency Analysis

% Theoretical complex multiplication counts
mult_DFT = N^2;
mult_FFT = (N/2)*M;

% Theoretical complex addition counts
add_DFT = N*(N-1);
add_FFT = N*M;

fprintf('\n===== Computational Efficiency =====\n');
fprintf('Number of samples: %d\n', N);
fprintf('Number of FFT stages: %d\n', M);

fprintf('\nTheoretical operation counts:\n');
fprintf('Direct DFT complex multiplications: %d\n', mult_DFT);
fprintf('DIF FFT non-trivial complex multiplications: %d\n', ...
    mult_FFT);
fprintf('Direct DFT complex additions: %d\n', add_DFT);
fprintf('DIF FFT complex additions/subtractions: %d\n', add_FFT);

%% 5. Visualization of Signal and Spectra

figure('Name','Radix-2 DIF FFT Analysis', ...
       'NumberTitle','off');

% Input signal
subplot(2,2,1);
stem(n,x,'filled','LineWidth',1.2);
grid on;
xlabel('Sample Index (n)');
ylabel('Amplitude');
title('Input Discrete-Time Signal');

% Magnitude spectrum
subplot(2,2,2);
stem(k,abs(X_DFT),'b','filled','LineWidth',1.2);
hold on;
stem(k,abs(X_DIF),'r--','LineWidth',1.2);
grid on;
xlabel('Frequency Index (k)');
ylabel('Magnitude');
title('Magnitude Spectrum');
legend('Direct DFT','Radix-2 DIF FFT');

% Phase spectrum
subplot(2,2,3);
stem(k,angle(X_DFT),'b','filled','LineWidth',1.2);
hold on;
stem(k,angle(X_DIF),'r--','LineWidth',1.2);
grid on;
xlabel('Frequency Index (k)');
ylabel('Phase (radians)');
title('Phase Spectrum');
legend('Direct DFT','Radix-2 DIF FFT');

% Absolute error
subplot(2,2,4);
stem(k,Error,'filled','LineWidth',1.2);
grid on;
xlabel('Frequency Index (k)');
ylabel('Absolute Error');
title('DFT vs DIF FFT Error');

sgtitle('Radix-2 Decimation-in-Frequency FFT');

%% 6. DIF FFT Butterfly Diagram

figure('Name','Radix-2 DIF FFT Butterfly Diagram', ...
       'NumberTitle','off','Color','w');

hold on;
axis off;

xPos = 1:M+1;
yPos = N:-1:1;

% Draw connections for each DIF stage
for stage = 1:M

    L = N/2^(stage-1);
    halfL = L/2;

    for start = 1:L:N
        for m = 0:halfL-1

            upper = start + m;
            lower = start + m + halfL;

            % Upper input to upper output
            plot([xPos(stage) xPos(stage+1)], ...
                 [yPos(upper) yPos(upper)], ...
                 'b-','LineWidth',1.2);

            % Lower input to lower output
            plot([xPos(stage) xPos(stage+1)], ...
                 [yPos(lower) yPos(lower)], ...
                 'b-','LineWidth',1.2);

            % Upper-to-lower cross connection
            plot([xPos(stage) xPos(stage+1)], ...
                 [yPos(upper) yPos(lower)], ...
                 'r--','LineWidth',1.0);

            % Lower-to-upper cross connection
            plot([xPos(stage) xPos(stage+1)], ...
                 [yPos(lower) yPos(upper)], ...
                 'g--','LineWidth',1.0);
        end
    end
end

% Display intermediate values in natural row order
for stage = 1:M+1
    for i = 1:N

        val = stageData(i,stage);

        label = sprintf('%.2f%+.2fj', ...
            real(val),imag(val));

        text(xPos(stage),yPos(i),label, ...
             'HorizontalAlignment','center', ...
             'VerticalAlignment','middle', ...
             'FontSize',8,'BackgroundColor','w');
    end
end

% Stage labels
labels = {'Input','Stage 1','Stage 2','Stage 3'};

for stage = 1:M+1
    text(xPos(stage),N+0.8,labels{stage}, ...
         'HorizontalAlignment','center', ...
         'FontWeight','bold','FontSize',10);
end

title('Radix-2 DIF FFT Butterfly Diagram');
xlim([0.5 M+1.5]);
ylim([0 N+1.5]);

hold off;

