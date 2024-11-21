% Step 1: Import Data
data = readtable('hydrophone.csv');  % Load the CSV file

% Extract relevant columns
time = data{:, 10};        % Column 10: Time instants
voltage = data{:, 5};     

% Step 2: Perform FFT
Fs = 1 / (time(2) - time(1));  % Sampling frequency (inverse of time step)
n = length(voltage);           % Number of samples
frequencies = (-n/2:n/2-1) * (Fs / n); % Frequency axis (centered at 0)

% FFT computation
fft_result = fft(voltage);
fft_result_shifted = fftshift(fft_result); % Center zero frequency

% Magnitude and Phase
magnitude = abs(fft_result_shifted);       % Magnitude of FFT
phase = angle(fft_result_shifted);         % Phase of FFT

% Convert magnitude to dB scale
magnitude_db = 20 * log10(magnitude);

% Step 3: Plot the Magnitude and Phase Spectra
figure;

% Magnitude Spectrum
subplot(2, 1, 1);
plot(frequencies, magnitude_db); % Full spectrum with FFT shifted
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('Magnitude Spectrum (Centered)');
grid on;

% Phase Spectrum
subplot(2, 1, 2);
plot(frequencies, phase); % Full spectrum with FFT shifted
xlabel('Frequency (Hz)');
ylabel('Phase (radians)');
title('Phase Spectrum (Centered)');
grid on;

% Step 4: Calculate -3dB Bandwidth in fftshift
[peakValue, peakIdx] = max(magnitude_db); % Find peak magnitude and its index
threshold = peakValue - 3;                % -3dB threshold

% Find lower and upper -3dB points in the shifted spectrum
lowerIdx = find(magnitude_db(1:peakIdx) <= threshold, 1, 'last'); % Lower bound
upperIdx = find(magnitude_db(peakIdx:end) <= threshold, 1, 'first') + peakIdx - 1; % Upper bound

% Check if -3dB points are found
if isempty(lowerIdx) || isempty(upperIdx)
    disp('Warning: Unable to determine -3dB bandwidth in shifted spectrum. Returning 0 Hz.');
    f_lower = 0; % Set lower -3dB frequency to 0
    f_upper = 0; % Set upper -3dB frequency to 0
    bandwidth = 0; % Set bandwidth to 0
else
    f_lower = frequencies(lowerIdx); % Lower frequency at -3dB
    f_upper = frequencies(upperIdx); % Upper frequency at -3dB
    bandwidth = f_upper - f_lower;   % -3dB bandwidth
end

% Display -3dB bandwidth for shifted spectrum
disp(['-3dB Bandwidth (Shifted): ', num2str(bandwidth), ' Hz']);
disp(['Lower -3dB Frequency (Shifted): ', num2str(f_lower), ' Hz']);
disp(['Upper -3dB Frequency (Shifted): ', num2str(f_upper), ' Hz']);
