%% . SIGNAL PREPROCESSING
fprintf('Step 3: Preprocessing the noisy ECG signal...\n');

% 4.1 Baseline Wander Removal (High-pass filter)
fprintf('  - Removing baseline wander...\n');
fc_high = 0.5; % Cutoff frequency for high-pass filter
[b_hp, a_hp] = butter(4, fc_high/(fs/2), 'high');
ecg_hp = filtfilt(b_hp, a_hp, ecg_noisy);

% 4.2 Powerline Interference Removal (Notch filter)
fprintf('  - Removing powerline interference...\n');
f_notch = 50; % Notch frequency
Q = 30; % Quality factor
w0 = f_notch/(fs/2);
bw = w0/Q;
[b_notch, a_notch] = iirnotch(w0, bw);
ecg_notch = filtfilt(b_notch, a_notch, ecg_hp);

% 4.3 High-frequency noise removal (Low-pass filter)
fprintf('  - Removing high-frequency noise...\n');
fc_low = 40; % Cutoff frequency for low-pass filter
[b_lp, a_lp] = butter(6, fc_low/(fs/2), 'low');
ecg_filtered = filtfilt(b_lp, a_lp, ecg_notch);

% 4.4 Additional smoothing (Moving average)
window_size = 5;
ecg_smooth = movmean(ecg_filtered, window_size);

