% projection name: FFL-MPI-Data
% code usege: The data processing code for the sensor domain in the measured dataset, whose function is to read the voltage signals in the sensor domain of the dataset, convert them into sinograms via STFT, and reconstruct images through FBP.
% programer: Guanghui Li, Haicheng Du

clc;
clear;
close all;
% Load measured voltage signal data of phantom 1
% Replace the filename with your own storage location.
% This example code takes phantom 1 as an example, and users can modify the number to obtain data of other phantoms.
load('D:\FFL-MPI-Data\measured data\1\sensor_dataset\voltage_signal.mat');

% Define acquisition parameters
Angle = 31; % the number of rotations of FFL
ff = 1; % scanning frequency           
fd = 3000;   % excitation frequency     
Fs = 3e6;  % sampling frequency 
      
% The FFL scans the FOV twice within a 1-second period, and the average is calculated.
data = data((size(data,1)/2+1):end, :); 

% Sinogram generation parameters
P = 25; % pixel number
L = size(data, 1); % the length of raw signal
pFOV = L / P; % the length of pFOV size

% Generate sinogram by STFT
for i = 1:Angle
    for j = 1:P
        index = ((j-1)*pFOV+1):j*pFOV;
        signal = data(index, i);
        ff_result = fft(signal);
        sinogram_fft(j, i) = -imag(ff_result(181)); 
    end
end
% Sinogram interpolation and image reconstruction
sinogram_fft = interp2(sinogram_fft, 1);
ang_seq = 0:3:180;
img_fft = iradon(sinogram_fft, ang_seq, "spline", "Cosine", 1, 49);
% Display reconstructed image
figure;
imagesc(img_fft); 
colorbar; axis equal; axis off; 
colormap(viridis);
title('Reconstructed Image'); 
fprintf('Image size: %d x %d pixels\n', size(img_fft, 1), size(img_fft, 2));