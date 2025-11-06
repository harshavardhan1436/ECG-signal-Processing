%% ECG Signal Preprocessing and Analysis for Cardiac Health Monitoring
% A comprehensive MATLAB implementation for ECG signal processing


clear all; close all; clc;

%% 1. INTRODUCTION AND PROJECT SETUP
fprintf('=== ECG Signal Preprocessing and Analysis Project ===\n');
fprintf('Objective: Preprocess and analyze ECG signals for cardiac health monitoring\n\n');

% Set sampling parameters
fs = 500; % Sampling frequency (Hz) - typical for ECG
duration = 10; % Duration in seconds
t = 0:1/fs:(duration-1/fs); % Time vector
N = length(t); % Number of samples


