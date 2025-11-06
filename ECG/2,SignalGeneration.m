%% 2. ECG SIGNAL GENERATION (Simulated)
% Generate a synthetic ECG signal for demonstration
fprintf('Step 1: Generating synthetic ECG signal...\n');

% Basic ECG waveform parameters
heart_rate = 75; % beats per minute
beat_duration = 60/heart_rate; % duration of one beat in seconds
num_beats = floor(duration/beat_duration);

% Generate clean ECG signal
ecg_clean = zeros(size(t));
for i = 1:num_beats
    beat_start = (i-1) * beat_duration;
    beat_indices = find(t >= beat_start & t < beat_start + beat_duration);
    
    if ~isempty(beat_indices)
        % Simplified ECG waveform (P-QRS-T complex)
        beat_time = t(beat_indices) - beat_start;
        
        % P wave (0.1s duration, low amplitude)
        p_wave = 0.1 * exp(-((beat_time - 0.15)/0.05).^2);
        
        % QRS complex (0.08s duration, high amplitude)
        qrs_complex = 1.5 * exp(-((beat_time - 0.35)/0.02).^2);
        
        % T wave (0.2s duration, medium amplitude)
        t_wave = 0.4 * exp(-((beat_time - 0.6)/0.08).^2);
        
        ecg_clean(beat_indices) = p_wave + qrs_complex + t_wave;
    end
end

