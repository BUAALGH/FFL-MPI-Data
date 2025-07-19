% projection name: FFL-MPI-Data
% code usege: The data processing code for the sensor domain in the measured dataset, whose function is to read the voltage signals in the sensor domain of the dataset, convert them into sinograms via STFT, and reconstruct images through FBP.
% programer: Guanghui Li, Haicheng Du

clc;
clear;
close all;

% Load sinogram data and viridis colormap
% Replace the filename with your own storage location.
% This example code takes phantom 1 as an example, and users can modify the number to obtain data of other phantoms.
load('E:\FFL-MPI-Data\simulation data\sinogram_dataset\train_dataset\K_3\imag_part\sinogram_imag_synomag_3rd.mat');

% Get sinogram data and image reconstruction
sinogram_fft = sinogram_imag_synomag_3rd(:,:,1)
sinogram_fft = interp2(sinogram_fft, 1);
ang_seq = 0:3:180;
img_fft = iradon(sinogram_fft, ang_seq, "spline", "none", 1, 59);
% Display reconstructed image
figure;
imagesc(img_fft); 
colorbar; axis equal; axis off; 
colormap(viridis);
title('Reconstructed Image'); 
fprintf('Image size: %d x %d pixels\n', size(img_fft, 1), size(img_fft, 2));