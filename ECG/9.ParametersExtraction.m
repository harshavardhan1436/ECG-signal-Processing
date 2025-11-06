%% Cardiac Disease Detection System

%% 2. DISEASE SIMULATION MODE SELECTION
fprintf('Select ECG Signal Type:\n');
fprintf('1. Normal Sinus Rhythm\n');
fprintf('2. Bradycardia (Slow Heart Rate)\n');
fprintf('3. Tachycardia (Fast Heart Rate)\n');
fprintf('4. Atrial Fibrillation (Irregular Rhythm)\n');
% For demonstration, we'll generate all types
signal_type = 1; % Change this to test different conditions


%% 3. ECG SIGNAL GENERATION WITH DISEASE PATTERNS
fprintf('\nStep 1: Generating ECG signal with pathological conditions...\n');

% Generate ECG based on selected disease
[ecg_clean, disease_params] = generate_ecg_with_disease(t, fs, signal_type);

fprintf('Generated signal type: %s\n', disease_params.condition);



%% 4. CARDIAC PARAMETER EXTRACTION
fprintf('Step 5: Extracting cardiac parameters...\n');

cardiac_params = struct();

if length(qrs_locations) > 1
    % R-R intervals
    rr_intervals = diff(qrs_times);
    cardiac_params.rr_mean = mean(rr_intervals);
    cardiac_params.rr_std = std(rr_intervals);
    
    % Heart rate
    cardiac_params.hr_inst = 60 ./ rr_intervals;
    cardiac_params.hr_mean = mean(cardiac_params.hr_inst);
    cardiac_params.hr_std = std(cardiac_params.hr_inst);
    cardiac_params.hr_min = min(cardiac_params.hr_inst);
    cardiac_params.hr_max = max(cardiac_params.hr_inst);
    
    % HRV metrics
    cardiac_params.rmssd = sqrt(mean(diff(rr_intervals).^2));
    cardiac_params.sdnn = std(rr_intervals);
    cardiac_params.pnn50 = sum(abs(diff(rr_intervals)) > 0.05) / length(diff(rr_intervals)) * 100;
    
    % Rhythm regularity (coefficient of variation)
    cardiac_params.cv = cardiac_params.rr_std / cardiac_params.rr_mean;
    
    fprintf('  - Mean Heart Rate: %.1f BPM\n', cardiac_params.hr_mean);
    fprintf('  - HR Variability: %.1f BPM\n', cardiac_params.hr_std);
    fprintf('  - RMSSD: %.3f s\n', cardiac_params.rmssd);
end
