% Step 1: Define the time vector and the function y(t) = e^(-3t)u(t)
sample_rate = 1200;          % Sampling frequency (Hz)
time_vector = 0:1/sample_rate:5; % Time vector from 0 to 5 seconds
signal = exp(-3*time_vector);   % Function e^(-3t) for t >= 0 (u(t) is implied)

% Step 2: Compute the FFT of the signal
num_samples = length(signal);   % Total number of samples
fft_signal = fft(signal);       % Compute FFT using MATLAB's fft function

% Step 3: Apply fftshift for symmetric frequency axis
fft_signal_shifted = fftshift(fft_signal);  % Shift zero frequency to center
frequencies = (-num_samples/2:num_samples/2-1)*(sample_rate/num_samples); % Symmetric frequency axis

% Step 4: Compute magnitude and phase of the shifted FFT
magnitude_spectrum = abs(fft_signal_shifted);  % Magnitude of the Fourier transform
phase_spectrum = angle(fft_signal_shifted);    % Phase of the Fourier transform

% Scale the magnitude to reduce the peak to 0.5
scaled_magnitude = magnitude_spectrum / max(magnitude_spectrum) * 0.5;  % Scale magnitude to peak at 0.5

% Step 5: Plot the results
figure;

% Plot the magnitude spectrum
subplot(2, 1, 1);
plot(frequencies, scaled_magnitude, 'LineWidth', 1.5);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Magnitude Spectrum of e^{-3t}u(t)');
xlim([-50 50]);             % Limit the x-axis to [-50, 50]
ylim([0 0.6]);              % Set y-axis limits from 0 to 0.6
grid on;

% Plot the phase spectrum
subplot(2, 1, 2);
plot(frequencies, phase_spectrum, 'LineWidth', 1.5);
xlabel('Frequency (Hz)');
ylabel('Phase (radians)');
title('Phase Spectrum of e^{-3t}u(t)');
xlim([-50 50]);             % Limit the x-axis to [-50, 50]
grid on;
