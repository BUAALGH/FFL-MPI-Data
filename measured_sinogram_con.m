% projection name: FFL-MPI-Data
% code usege: The data processing code for the sensor domain in the measured dataset, whose function is to read the voltage signals in the sensor domain of the dataset, convert them into sinograms via STFT, and reconstruct images through FBP.
% programer: Guanghui Li, Haicheng Du

clc;
clear;
close all;
% Load sinogram data and viridis colormap
load('E:\FFL-MPI-Data\measured data\1\sinogram_dataset\K_3\imag_part\sinogram_imag.mat');
load viridis.mat
% Get sinogram data and image reconstruction
sinogram_fft = sinogram_imag
ang_seq = 0:3:180;
img_fft = iradon(sinogram_fft, ang_seq, "spline", "Cosine", 1, 49);
% Display reconstructed image
figure;
imagesc(img_fft); 
colorbar; axis equal; axis off; 
colormap(viridis);
title('Reconstructed Image'); 
fprintf('Image size: %d x %d pixels\n', size(img_fft, 1), size(img_fft, 2));