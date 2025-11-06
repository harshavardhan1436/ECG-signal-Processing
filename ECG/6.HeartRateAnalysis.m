

%% 6. HEART RATE ANALYSIS
fprintf('Step 5: Analyzing heart rate...\n');

if length(qrs_locations) > 1
    % Calculate R-R intervals
    rr_intervals = diff(qrs_times);
    
    % Calculate heart rate
    instantaneous_hr = 60 ./ rr_intervals; % beats per minute
    mean_hr = mean(instantaneous_hr);
    std_hr = std(instantaneous_hr);
    
    % Heart Rate Variability (HRV) metrics
    rmssd = sqrt(mean(diff(rr_intervals).^2)); % RMSSD
    pnn50 = sum(abs(diff(rr_intervals)) > 0.05) / length(diff(rr_intervals)) * 100; % pNN50
    
    fprintf('  - Mean Heart Rate: %.1f BPM\n', mean_hr);
    fprintf('  - Heart Rate Variability (RMSSD): %.3f seconds\n', rmssd);
    fprintf('  - pNN50: %.1f%%\n', pnn50);
else
    fprintf('  - Insufficient QRS complexes for HR analysis\n');
    mean_hr = NaN; std_hr = NaN; rmssd = NaN; pnn50 = NaN;
end

