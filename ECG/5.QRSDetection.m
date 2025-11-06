
%% 5. QRS DETECTION
fprintf('Step 4: Detecting QRS complexes...\n');

% Pan-Tompkins algorithm implementation (simplified)
% 5.1 Differentiation
ecg_diff = diff(ecg_smooth);
ecg_diff = [ecg_diff(1) ecg_diff]; % Maintain same length

% 5.2 Squaring
ecg_squared = ecg_diff.^2;

% 5.3 Moving average integration
integration_window = round(0.15 * fs); % 150ms window
ecg_integrated = movmean(ecg_squared, integration_window);

% 5.4 Peak detection
threshold = 0.3 * max(ecg_integrated);
[peaks, peak_locations] = findpeaks(ecg_integrated, 'MinPeakHeight', threshold, ...
                                   'MinPeakDistance', round(0.6*fs)); % Min 600ms between peaks

% Map back to original signal
qrs_locations = peak_locations;
qrs_times = t(qrs_locations);

fprintf('  - Detected %d QRS complexes\n', length(qrs_locations));

