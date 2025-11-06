%% 5. ADVANCED DISEASE DETECTION ALGORITHM
fprintf('\nStep 6: CARDIAC DISEASE DETECTION ALGORITHM\n');
fprintf('================================================\n');

disease_detection = struct();

% Initialize detection flags
disease_detection.normal = true;
disease_detection.conditions = {};
disease_detection.severity = 'None';
disease_detection.confidence = 0;

if length(qrs_locations) > 1
    
    %% 8.1 BRADYCARDIA DETECTION
    fprintf('\n[1] Bradycardia Detection:\n');
    if cardiac_params.hr_mean < 60
        disease_detection.bradycardia = true;
        disease_detection.normal = false;
        disease_detection.conditions{end+1} = 'Bradycardia';
        
        if cardiac_params.hr_mean < 40
            severity = 'Severe';
            confidence = 95;
        elseif cardiac_params.hr_mean < 50
            severity = 'Moderate';
            confidence = 90;
        else
            severity = 'Mild';
            confidence = 85;
        end
        
        fprintf('  ✓ DETECTED: Bradycardia (%s)\n', severity);
        fprintf('  - Mean HR: %.1f BPM (Normal: 60-100 BPM)\n', cardiac_params.hr_mean);
        fprintf('  - Confidence: %d%%\n', confidence);
        fprintf('  - Clinical Significance: Abnormally slow heart rate\n');
    else
        disease_detection.bradycardia = false;
        fprintf('  ✗ Not detected (HR: %.1f BPM)\n', cardiac_params.hr_mean);
    end
    
    %% 8.2 TACHYCARDIA DETECTION
    fprintf('\n[2] Tachycardia Detection:\n');
    if cardiac_params.hr_mean > 100
        disease_detection.tachycardia = true;
        disease_detection.normal = false;
        disease_detection.conditions{end+1} = 'Tachycardia';
        
        if cardiac_params.hr_mean > 150
            severity = 'Severe';
            confidence = 95;
        elseif cardiac_params.hr_mean > 120
            severity = 'Moderate';
            confidence = 90;
        else
            severity = 'Mild';
            confidence = 85;
        end
        
        fprintf('  ✓ DETECTED: Tachycardia (%s)\n', severity);
        fprintf('  - Mean HR: %.1f BPM (Normal: 60-100 BPM)\n', cardiac_params.hr_mean);
        fprintf('  - Confidence: %d%%\n', confidence);
        fprintf('  - Clinical Significance: Abnormally fast heart rate\n');
    else
        disease_detection.tachycardia = false;
        fprintf('  ✗ Not detected (HR: %.1f BPM)\n', cardiac_params.hr_mean);
    end
    
    %% 8.3 ARRHYTHMIA (IRREGULAR RHYTHM) DETECTION
    fprintf('\n[3] Arrhythmia (Irregular Rhythm) Detection:\n');
    
    % Calculate rhythm regularity metrics
    rr_variability = cardiac_params.cv;
    
    if rr_variability > 0.15
        disease_detection.arrhythmia = true;
        disease_detection.normal = false;
        disease_detection.conditions{end+1} = 'Arrhythmia';
        
        if rr_variability > 0.30
            severity = 'Severe';
            confidence = 92;
        elseif rr_variability > 0.20
            severity = 'Moderate';
            confidence = 88;
        else
            severity = 'Mild';
            confidence = 82;
        end
        
        fprintf('  ✓ DETECTED: Irregular Rhythm (%s)\n', severity);
        fprintf('  - Coefficient of Variation: %.3f (Normal: <0.15)\n', rr_variability);
        fprintf('  - HR Std Dev: %.1f BPM\n', cardiac_params.hr_std);
        fprintf('  - Confidence: %d%%\n', confidence);
        fprintf('  - Clinical Significance: Inconsistent beat-to-beat intervals\n');
    else
        disease_detection.arrhythmia = false;
        fprintf('  ✗ Not detected (CV: %.3f)\n', rr_variability);
    end
    
    %% 8.4 ATRIAL FIBRILLATION DETECTION
    fprintf('\n[4] Atrial Fibrillation (AF) Detection:\n');
    
    % AF characteristics: irregular RR intervals + absent P waves
    % Here we check for highly irregular rhythm with high variability
    
    if rr_variability > 0.25 && cardiac_params.pnn50 > 15
        disease_detection.atrial_fib = true;
        disease_detection.normal = false;
        disease_detection.conditions{end+1} = 'Atrial Fibrillation';
        
        confidence = 87;
        
        fprintf('  ✓ DETECTED: Possible Atrial Fibrillation\n');
        fprintf('  - RR Irregularity: %.3f (Highly irregular)\n', rr_variability);
        fprintf('  - pNN50: %.1f%% (High variability)\n', cardiac_params.pnn50);
        fprintf('  - Confidence: %d%%\n', confidence);
        fprintf('  - Clinical Significance: Chaotic atrial activity, stroke risk\n');
    else
        disease_detection.atrial_fib = false;
        fprintf('  ✗ Not detected\n');
    end
end