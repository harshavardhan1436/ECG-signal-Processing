%% Tachycardia ECG Simulation
clear; clc; close all;
fs = 500; duration = 5;
t = 0:1/fs:duration;
N=length(t);

% Higher frequency = faster heart rate (120 bpm)
heart_rate = 120;
ecg = 1.2 * sawtooth(2*pi*(heart_rate/60)*t, 0.3);

plot(t, ecg, 'r', 'LineWidth', 1.5);
title('Tachycardia (High Heart Rate)');
xlabel('Time (s)'); ylabel('Amplitude (mV)');
grid on;




%% Bradycardia ECG Simulation
clear; clc; close all;
fs = 500; duration = 5;
t = 0:1/fs:duration;
N=length(t);

% Lower frequency = slower heart rate (45 bpm)
heart_rate = 45;
ecg = 1.3 * sawtooth(2*pi*(heart_rate/60)*t, 0.3);

plot(t, ecg, 'm', 'LineWidth', 1.5);
title('Bradycardia (Low Heart Rate)');
xlabel('Time (s)'); ylabel('Amplitude (mV)');
grid on;




%% Arrhythmia ECG Simulation
clear; clc; close all;
fs = 500; duration = 5;
t = 0:1/fs:duration;
N=length(t);

% Variable heart rate pattern
heart_rate = 60 + 20*sin(2*pi*0.3*t); % irregular frequency
ecg = 1.5 * sawtooth(2*pi*(heart_rate/60).*t, 0.3);

plot(t, ecg, 'k', 'LineWidth', 1.5);
title('Arrhythmia (Irregular Heartbeat)');
xlabel('Time (s)'); ylabel('Amplitude (mV)');
grid on;





%% Atrial Fibrillation ECG Simulation
clear; clc; close all;
fs = 500; duration = 5;
t = 0:1/fs:duration;
N=length(t);

% Base sinusoidal rhythm with random perturbations
base_hr = 80; 
ecg = 1.2 * sin(2*pi*(base_hr/60)*t);
% Add random irregularity and noise
ecg = ecg + 0.4*randn(size(t)) + 0.6*sin(2*pi*(base_hr/60)*t + 0.5*randn(size(t)));

plot(t, ecg, 'Color', [0 0.5 0.9], 'LineWidth', 1.5);
title('Atrial Fibrillation (Irregular + Noisy ECG)');
xlabel('Time (s)'); ylabel('Amplitude (mV)');
grid on;