% Step 1: Generate Sound Sequence
sampling_rate = 8000;           % Sampling rate (Hz)
note_duration = 0.4;            % Duration of each note (seconds)
time_vec = 0:1/sampling_rate:note_duration-1/sampling_rate; % Time vector for one note

% Define note frequencies (C4, E4, G4, C5)
note_freqs = [261.63, 329.63, 392.00, 523.25];  % Frequencies in Hz
sound_sequence = []; % Initialize sound array

% Create sound sequence by concatenating sine waves
for idx = 1:length(note_freqs)
    note_signal = sin(2 * pi * note_freqs(idx) * time_vec); % Sine wave for each note
    sound_sequence = [sound_sequence, note_signal];  % Append note to sound sequence
end

% Add pause between notes
pause_len = 0.1;  % Pause duration (seconds)
pause_sound = zeros(1, round(pause_len * sampling_rate));

% Concatenate sound and pause
sound_sequence = [sound_sequence, pause_sound];

% Play sound sequence
disp('Playing sound sequence...');
sound(sound_sequence, sampling_rate);

% Step 2: Compute DFT Manually
sample_count = length(sound_sequence);    % Number of samples
dft_manual = zeros(1, sample_count); % Initialize DFT result
for k = 1:sample_count
    for n = 1:sample_count
        dft_manual(k) = dft_manual(k) + sound_sequence(n) * exp(-1j * 2 * pi * (k-1) * (n-1) / sample_count);
    end
end

% Step 3: Compute FFT Using MATLAB
dft_fft = fft(sound_sequence);

% Step 4: Compare Results
magnitude_manual_dft = abs(dft_manual);  % Magnitude of manual DFT
magnitude_fft_dft = abs(dft_fft);        % Magnitude of FFT

% Frequency axis
freq_axis = (0:sample_count-1) * (sampling_rate / sample_count);

% Plot results
figure;

% Manual DFT plot
subplot(2, 1, 1);
plot(freq_axis, magnitude_manual_dft, 'r', 'LineWidth', 1.5);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Manual DFT Result');
grid on;

% FFT plot
subplot(2, 1, 2);
plot(freq_axis, magnitude_fft_dft, 'b', 'LineWidth', 1.5);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('FFT Result from MATLAB');
grid on;

% Step 5: Verify DFT and FFT Comparison
diff_magnitude = max(abs(magnitude_manual_dft - magnitude_fft_dft));  % Maximum difference
disp(['Maximum Difference Between Manual DFT and FFT: ', num2str(diff_magnitude)]);
