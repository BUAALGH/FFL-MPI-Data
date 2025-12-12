%% FFL-MPI Image Reconstruction Demo
% Project: FFL-MPI-Data
% Author: Guanghui Li, Haicheng Du
% Date: 2025-11
% Description: This script loads measured FFL-MPI voltage signals, 
% performs sinogram construction via STFT, and reconstructs the image 
% using Filtered Back Projection (FBP).

clc;
clear;
close all;

addpath(genpath('68'));
%% 1 Loading measured voltage signal data in sensor domain
fprintf('Loading data and parameters...\n');

% Replace the filename "***" with your own file location.
% This demo codes take the "1" phantom as example
load('68\sensor_dataset\voltage_signal.mat')
[M, ~] = size(voltage_signal);  % raw data length of voltage signal

%% 2 Loading scanning parameters
run("scanning_parameters.m");
% The FFL scans the FOV twice within a 1-second period, 0.5s signals are
% extracted for analysis.
data = voltage_signal((M/2+1):end, :); 
[signal_length, angle] = size(data);

fprintf('voltage signal has been loaded with size [%d, %d]\n', size(data));

%% 3 Sinogram construction
fprintf('Starting sinogram reconstruction...\n');
P = 25;                         % pixel number or pFOV number
pFOV = signal_length / P;       % the length of pFOV size
correction_coefficient = -1;    % phase correction coefficient

% --- % 3rd harmonics as example % --- %
harmonics = 3;
signal_index = harmonics * fd /(Fs / pFOV)+1;

% construction sinogram by STFT with P pFOV windows
for i = 1:angle
    for j = 1:P
        index = ((j-1)*pFOV+1):j*pFOV;
        signal_pFOV = data(index, i);   % extract the j_th pFOV data
        ff_result = fft(signal_pFOV);   % fft transform of the pFOV data
        % extract all the projected harmonics data to construct sinogram
        sinogram_fft(j, i) = correction_coefficient * imag(ff_result(signal_index)); 
    end
end
fprintf('sinogram has been constructed with size [%d, %d]\n', size(sinogram_fft));

%% 4 Sinogram interpolation and image reconstruction
fprintf('Starting image reconstruction...\n');
sinogram_fft = interp2(sinogram_fft, 1); % interpolation to get higher resolution
sinogram_fft = fliplr(sinogram_fft);
[position, angle_number] = size(sinogram_fft);
angle_sequence_interp = 0:3:180;    % interpolated angle sequence
% image reconstruction by iradon function
img_fft = iradon(sinogram_fft, angle_sequence_interp, "spline", "ram-lak", 1, position);
fprintf('image has been constructed with size [%d, %d]\n', size(img_fft));

%% 5 visualization
fprintf('Generating visualization...\n');
figure;
subplot(1,2,1)
imagesc(sinogram_fft);
colorbar; axis equal; axis off;axis tight;colormap("gray");
title('Reconstructed sinogram'); 
subplot(1,2,2)
imagesc(img_fft); 
colorbar; axis equal; axis off;axis tight;colormap("gray");
title('Reconstructed Image'); 