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

%% 1 Loading measured sinogram data
fprintf('Loading raw sinogram data ...\n');

% Replace the filename "***" with your own file location.
% This demo codes take the "1" phantom as example
load('68\sinogram_dataset\K_3\imag_part\sinogram_imag.mat');
[M, N] = size(sinogram_imag);   % the size of raw sinogram data 
fprintf('sinogram has been loaded with size [%d, %d]\n', size(sinogram_imag));
%% 2 Image reconstruction
fprintf('Starting image reconstruction...\n');
correction_coefficient = -1;    % phase correction coefficient
angle_sequence = 0:3:180;       % angle sequence of raw sinogram data
sinogram_fft = correction_coefficient * sinogram_imag;   % phase correction
sinogram_fft = fliplr(sinogram_fft);
img_fft = iradon(sinogram_fft, angle_sequence, "spline", "ram-lak", 1, M);
fprintf('image has been constructed with size [%d, %d]\n', size(img_fft));

%% 3 visualization
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