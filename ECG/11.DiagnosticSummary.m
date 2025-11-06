%%6. DIAGNOSTIC SUMMARY
fprintf('\n================================================\n');
fprintf('DIAGNOSTIC SUMMARY\n');
fprintf('======%% ==========================================\n');

if disease_detection.normal
    fprintf('✓ RESULT: Normal Sinus Rhythm\n');
    fprintf('  All parameters within normal limits\n');
else
    fprintf('⚠ RESULT: Abnormality Detected\n');
    fprintf('  Detected Conditions:\n');
    for i = 1:length(disease_detection.conditions)
        fprintf('    %d. %s\n', i, disease_detection.conditions{i});
    end
end

fprintf('\nClinical Recommendations:\n');
if disease_detection.normal
    fprintf('  - Continue regular monitoring\n');
    fprintf('  - Maintain healthy lifestyle\n');
else
    fprintf('  - Consult cardiologist for detailed evaluation\n');
    fprintf('  - Consider Holter monitoring for 24-48 hours\n');
    fprintf('  - Additional diagnostic tests may be required\n');
    if isfield(disease_detection, 'v_fib') && disease_detection.v_fib
        fprintf('  - ⚠ EMERGENCY: Immediate medical intervention required!\n');
    end
end

%% 7. COMPREHENSIVE VISUALIZATION
fprintf('\nStep 7: Creating diagnostic visualizations...\n');

% Main diagnostic figure
figure('Position', [50, 50, 1400, 900], 'Name', 'ECG Cardiac Disease Detection');

% Plot 7: Poincaré Plot (HRV analysis)
subplot(3, 4, 7);
if length(rr_intervals) > 1
    plot(rr_intervals(1:end-1), rr_intervals(2:end), 'bo', 'MarkerSize', 8);
    hold on;
    plot([0, max(rr_intervals)], [0, max(rr_intervals)], 'r--');
    title('Poincaré Plot (HRV)');
    xlabel('RR_{n} (s)'); ylabel('RR_{n+1} (s)');
    axis equal; grid on;
end


% Plot 9-12: Disease Detection Status
disease_names = {'Bradycardia', 'Tachycardia', 'Arrhythmia', 'Atrial Fib' ...
                };
disease_fields = {'bradycardia', 'tachycardia', 'arrhythmia', 'atrial_fib' ...
                 };

for i = 1:4
    subplot(3, 4, 8+i);
    axis off;
    
    if i <= length(disease_names)
        status_text = {};
        status_text{1} = ['[' disease_names{i} ' Detection]'];
        status_text{2} = '─────────────────────';
        
        if isfield(disease_detection, disease_fields{i})
            if disease_detection.(disease_fields{i})
                status_text{3} = '⚠ POSITIVE';
                status_text{4} = 'Status: DETECTED';
                text_color = [0.8, 0.2, 0.2];
            else
                status_text{3} = '✓ NEGATIVE';
                status_text{4} = 'Status: Not Detected';
                text_color = [0.2, 0.6, 0.2];
            end
        else
            status_text{3} = '○ Not Analyzed';
            text_color = [0.5, 0.5, 0.5];
        end
        
        text(0.5, 0.6, status_text, 'FontSize', 10, 'FontWeight', 'bold', ...
             'HorizontalAlignment', 'center', 'Color', text_color);
    end
end

sgtitle('ECG Cardiac Disease Detection System - Diagnostic Report', ...
        'FontSize', 16, 'FontWeight', 'bold');
