%%DIAGNOSTIC REPORT:

%% 1. DETAILED DIAGNOSTIC REPORT
figure('Position', [100, 100, 900, 700], 'Name', 'Clinical Diagnostic Report');
axis off;

report_text = {};
report_text{end+1} = '╔═══════════════════════════════════════════════════════════╗';
report_text{end+1} = '║     CARDIAC DIAGNOSTIC REPORT - ECG ANALYSIS SYSTEM       ║';
report_text{end+1} = '╚═══════════════════════════════════════════════════════════╝';
report_text{end+1} = '';
report_text{end+1} = '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━';
report_text{end+1} = 'VITAL PARAMETERS:';
report_text{end+1} = '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━';

if length(qrs_locations) > 1
    report_text{end+1} = sprintf('  Heart Rate:');
    report_text{end+1} = sprintf('    • Mean:        %.1f BPM', cardiac_params.hr_mean);
    report_text{end+1} = sprintf('    • Range:       %.1f - %.1f BPM', cardiac_params.hr_min, cardiac_params.hr_max);
    report_text{end+1} = sprintf('    • Std Dev:     %.1f BPM', cardiac_params.hr_std);
    report_text{end+1} = '';
    report_text{end+1} = sprintf('  RR Intervals:');
    report_text{end+1} = sprintf('    • Mean:        %.3f s', cardiac_params.rr_mean);
    report_text{end+1} = sprintf('    • Std Dev:     %.3f s', cardiac_params.rr_std);
    report_text{end+1} = sprintf('    • CV:          %.3f', cardiac_params.cv);
    report_text{end+1} = '';
    report_text{end+1} = sprintf('  HRV Metrics:');
    report_text{end+1} = sprintf('    • RMSSD:       %.3f s', cardiac_params.rmssd);
    report_text{end+1} = sprintf('    • SDNN:        %.3f s', cardiac_params.sdnn);
    report_text{end+1} = sprintf('    • pNN50:       %.1f%%', cardiac_params.pnn50);
end


report_text{end+1} = '';
report_text{end+1} = '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━';
report_text{end+1} = 'CLINICAL RECOMMENDATIONS:';
report_text{end+1} = '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━';

if disease_detection.normal
    report_text{end+1} = '  • Continue routine cardiac monitoring';
    report_text{end+1} = '  • Maintain healthy lifestyle habits';
    report_text{end+1} = '  • Regular exercise and balanced diet';
else
    report_text{end+1} = '  • Immediate cardiology consultation recommended';
    report_text{end+1} = '  • Consider 24-48 hour Holter monitoring';
    report_text{end+1} = '  • Further diagnostic tests advised';
    if isfield(disease_detection, 'v_fib') && disease_detection.v_fib
        report_text{end+1} = '  • ⚠️ EMERGENCY: Immediate intervention required!';
    end
end

report_text{end+1} = '';
report_text{end+1} = '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━';
report_text{end+1} = sprintf('Report Generated: %s', datestr(now));
report_text{end+1} = '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━';

text(0.05, 0.95, report_text, 'FontSize', 10, 'FontName', 'FixedWidth', ...
     'VerticalAlignment', 'top', 'Interpreter', 'none');

fprintf('\n=== ECG Analysis Complete ===\n');
fprintf('All visualizations and diagnostic reports generated.\n\n');
