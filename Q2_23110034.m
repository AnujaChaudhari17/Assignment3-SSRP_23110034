% Parameters
pulse_duration = 1;       % Pulse duration (T)
alpha = 0.9;             % Energy fraction (90%)

% Sinc function (Frequency domain)
sinc_func = @(f) sinc(f * pulse_duration);

% Energy calculation function
energy_func = @(B) 2 * integral(@(f) abs(sinc_func(f)).^2, 0, B);

% Total and target energy
total_energy = pulse_duration;
target_energy =alpha * total_energy;

% Optimization to find 90% essential bandwidth
B_opt = fminsearch(@(B) abs(energy_func(B) - target_energy), 1); 

% Display result
disp(['90% Essential Bandwidth: B = ', num2str(B_opt), ' Hz.']);

% Plot
f_range = linspace(-5, 5, 1000);
sinc_squared = abs(sinc_func(f_range)).^2;

figure;
plot(f_range, sinc_squared, 'g', 'LineWidth', 1.5); hold on;
xline(B_opt, 'b--', 'LineWidth', 1.5); % Positive side
xline(-B_opt, 'b--', 'LineWidth', 1.5); % Negative side
text(B_opt + 0.1, 0.8, ['B = ', num2str(B_opt, '%.2f')], 'Color', 'blue', 'FontSize', 10);
text(-B_opt - 0.5, 0.8, ['B = ', num2str(-B_opt, '%.2f')], 'Color', 'blue', 'FontSize', 10);

% Labels and title
xlabel('Frequency (Hz)');
ylabel('|sinc(f)|^2');
title('Sinc Function & 90% Essential Bandwidth');
grid on;
legend('Sinc^2(f)', '90% Bandwidth');
hold off;
