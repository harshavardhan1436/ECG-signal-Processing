%% 3. NOISE ADDITION (Realistic noise simulation)
fprintf('Step 2: Adding realistic noise to ECG signal...\n');

% 1. Powerline interference (50Hz or 60Hz)
powerline_noise = 0.1 * sin(2*pi*50*t); % 50Hz interference

% 2. Baseline wander (low frequency drift)
baseline_wander = 0.05 * sin(2*pi*0.5*t) + 0.03 * cos(2*pi*1.2*t);

% 3. Muscle artifact (EMG noise)
emg_noise = 0.05 * randn(size(t)); % High frequency noise

% 4. Motion artifacts (random spikes)
motion_artifacts = zeros(size(t));
spike_locations = randperm(N, 5); % 5 random spikes
motion_artifacts(spike_locations) = 0.3 * (2*rand(1,5) - 1);

% Combine all noise sources
total_noise = powerline_noise + baseline_wander + emg_noise + motion_artifacts;

% Noisy ECG signal
ecg_noisy = ecg_clean + total_noise;



