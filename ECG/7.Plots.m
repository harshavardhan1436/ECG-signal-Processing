%% 9. VISUALIZATION
fprintf('Step 8: Creating comprehensive visualizations...\n');

figure('Position', [100, 100, 1200, 900]);

% Plot 1: Original and Noisy ECG
subplot(3, 3, 1);
plot(t, ecg_clean, 'b', 'LineWidth', 1.5); hold on;
plot(t, ecg_noisy, 'r', 'LineWidth', 0.8);
title('Original vs Noisy ECG Signal');
xlabel('Time (s)'); ylabel('Amplitude (mV)');
legend('Clean ECG', 'Noisy ECG', 'Location', 'best');
grid on;

% Plot 2: Preprocessing steps
subplot(3, 3, 2);
plot(t, ecg_noisy, 'r', 'LineWidth', 0.8); hold on;
plot(t, ecg_hp, 'g', 'LineWidth', 1);
plot(t, ecg_notch, 'b', 'LineWidth', 1);
plot(t, ecg_filtered, 'k', 'LineWidth', 1.5);
title('Preprocessing Steps');
xlabel('Time (s)'); ylabel('Amplitude (mV)');
legend('Noisy', 'High-pass', 'Notch', 'Low-pass', 'Location', 'best');
grid on;

% Plot 3: Final processed signal with QRS detection
subplot(3, 3, 3);
plot(t, ecg_filtered, 'b', 'LineWidth', 1.5); hold on;
plot(qrs_times, ecg_filtered(qrs_locations), 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
title('Processed ECG with QRS Detection');
xlabel('Time (s)'); ylabel('Amplitude (mV)');
legend('Filtered ECG', 'QRS Peaks', 'Location', 'best');
grid on;

% Plot 4: QRS Detection Process
subplot(3, 3, 4);
plot(t, ecg_integrated, 'g', 'LineWidth', 1); hold on;
plot(t, threshold * ones(size(t)), 'r--', 'LineWidth', 1);
plot(qrs_times, peaks, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
title('QRS Detection Algorithm');
xlabel('Time (s)'); ylabel('Integrated Signal');
legend('Integrated ECG', 'Threshold', 'Detected Peaks', 'Location', 'best');
grid on;

% Plot 5: Heart Rate Analysis
if length(qrs_locations) > 1
    subplot(3, 3, 5);
    plot(qrs_times(2:end), instantaneous_hr, 'bo-', 'LineWidth', 1.5, 'MarkerSize', 6);
    title(sprintf('Instantaneous Heart Rate (Mean: %.1f BPM)', mean_hr));
    xlabel('Time (s)'); ylabel('Heart Rate (BPM)');
    ylim([min(instantaneous_hr)-5, max(instantaneous_hr)+5]);
    grid on;
    
    % Plot 6: R-R Interval Analysis
    subplot(3, 3, 6);
    plot(rr_intervals, 'go-', 'LineWidth', 1.5, 'MarkerSize', 6);
    title(sprintf('R-R Intervals (RMSSD: %.3f s)', rmssd));
    xlabel('Beat Number'); ylabel('R-R Interval (s)');
    grid on;
else
    subplot(3, 3, 5);
    text(0.5, 0.5, 'Insufficient data for HR analysis', 'HorizontalAlignment', 'center');
    title('Heart Rate Analysis');
    
    subplot(3, 3, 6);
    text(0.5, 0.5, 'Insufficient data for R-R analysis', 'HorizontalAlignment', 'center');
    title('R-R Interval Analysis');
end

% Plot 7: Power Spectral Density
subplot(3, 3, 7);
semilogy(f_psd, psd, 'b', 'LineWidth', 1.5);
title('Power Spectral Density');
xlabel('Frequency (Hz)'); ylabel('PSD (mV²/Hz)');
xlim([0, 50]);
grid on;

% Plot 8: SNR Comparison
subplot(3, 3, 8);
snr_values = [snr_original, snr_processed];
bar_labels = {'Original', 'Processed'};
bar(snr_values, 'FaceColor', [0.3, 0.6, 0.8]);
set(gca, 'XTickLabel', bar_labels);
title('Signal-to-Noise Ratio Comparison');
ylabel('SNR (dB)');
for i = 1:length(snr_values)
    text(i, snr_values(i) + 0.5, sprintf('%.1f dB', snr_values(i)), ...
         'HorizontalAlignment', 'center', 'FontWeight', 'bold');
end
grid on;

% Plot 9: Summary Statistics
subplot(3, 3, 9);
axis off;
summary_text = {
    'ECG Analysis Summary:';
    '─────────────────────';
    sprintf('Duration: %.1f seconds', duration);
    sprintf('Sampling Rate: %d Hz', fs);
    sprintf('QRS Complexes: %d', length(qrs_locations));
    '';
    'Cardiac Parameters:';
    sprintf('Mean HR: %.1f BPM', mean_hr);
    sprintf('HRV (RMSSD): %.3f s', rmssd);
    sprintf('pNN50: %.1f%%', pnn50);
    '';
    'Signal Quality:';
    sprintf('SNR Improvement: %.1f dB', improvement);
};

text(0.1, 0.9, summary_text, 'FontSize', 10, 'VerticalAlignment', 'top', ...
     'FontName', 'FixedWidth');

sgtitle('ECG Signal Preprocessing and Analysis Results', 'FontSize', 14, 'FontWeight', 'bold');

