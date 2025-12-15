%% FFL-MPI Projection Imaging Simulation Framework
%
% **Project:** FFL-MPI-Data
% **Authors:** Guanghui Li
% **Date:** 2025-11
%
% Description:
% This project provides an open-source simulation framework for Field-Free Line (FFL) Magnetic Particle
% Imaging (MPI) Projection Imaging. 

% 1 - Dataset:
%   It utilizes the MNIST dataset as a digital phantom source, including 
%   60,000 for training and 10,000 for testing

% 2 - Models:
%   The framework includes  Langevin Model as magnetic particle models,
%   other Particle types can be added into the Models folder and change the
%   model index in Modules - Basic_setups.

% 3 - Noise:
%   noise_k_2.mat to noise_k_7.mat can be loaded as the background noise.
%   the noises are in image domain with size of [49,49]
%   the noises are directly added on the simulated images.

% 4 - Modules:
%   The simulation framework comprises the following modular components:
%       - Basic_setups.m: Configures fundamental parameters including gradient strength,...
%         ... excitation magnetic field amplitude, ADC sampling specifications, and nanoparticle type.
%       - Magnetic_Field_Generation.m: Generates the magnetic field required for imaging based on the predefined basic setups.
%       - Phantoms_Load.m: Loads digital images for simulation, such as those from the MNIST dataset.
%       - Signal_Generation.m: Computes the magnetization-induced signals of nanoparticles based on the implemented model 
%         (e.g., modified Jiles–Atherton) and the generated magnetic field.
%       - visualization.m: Performs visualization of the imaging results, including sinograms and reconstructed images.

% 5 - main.m
%   the main process pipeline, run the main.m to perform simulation

% Utility:
% Researchers can leverage this simulation tool for synthetic dataset generation and algorithm validation
% within the domain of MPI. As a foundational resource, it aims to provide deeper insights into the
% FFL-MPI Projection Imaging process and support the development of novel imaging algorithms.

clc
clear
close all

% --- Add necessary directories to the MATLAB path ---
addpath("Dataset\")      % Digital phantom datasets (e.g., MNIST)
addpath("Noise\")        % Noise models and functions
addpath("Models\")       % Particle models    
addpath("Modules\")      % functiional modules  
%% **Phase 1: Setup and Data Loading**
% ---------------------------------------

% Load basic physical and acquisition parameters (e.g., FOV, Fs, h, etc.)
run("Basic_setups.m")

% Generate magnetic field profiles (Drive Field, FFL parameters)
run("Magnetic_Field_Generation.m")

% Load digital phantoms (e.g., MNIST images)
run("Phantoms_Load.m")

%% **Phase 2: Signal Generation and Image Reconstruction**
% --------------------------------------------------------

% Configuration for simulation loop
N_phantoms = N_phantoms_total; % Number of phantoms to process

% Pre-run: Calculate magnetic response (dM)
run("Signal_Generation.m")

% Initialize result matrices
sinogram_imag = zeros(FOV, length(ang_seq), 'single');
img_reconstructed_imag = zeros(FOV, FOV, 'single');

fprintf("Starting signal generation and image reconstruction for %d phantoms...\n", N_phantoms);

for n = 1:N_phantoms
    % Extract the current phantom's sinogram-like structure
    sinogram_projection = phantoms(:,:,n);
    
    % Initialize 'signal' for the current phantom
    % The size should be based on (total time points x number of projections)
    signal = zeros(size(dM, 1), length(ang_seq), 'single'); 

    for i = 1:length(ang_seq)
        % Ground Truth (GT) concentration profile for the current angle 'i'
        GT_concentration = single( sinogram_projection(:,i) );
        
        % Forward Model: Compute the raw time-domain signal
        signal(:,i) = dM * GT_concentration;
        
        % Process the time-domain signal to extract the required harmonic (h)
        for j = 1:FOV
            % Define the time index range corresponding to the spatial pixel 'j'
            index = ((j-1) * partial_FOV_length + 1) : (j * partial_FOV_length);
            
            data_segment = signal(index, i);
            ff_spectrum = fft(data_segment);
            
            % Extract the imaginary part of the h-th harmonic
            % Assuming 'h' is the index of the relevant harmonic (e.g., 2nd or 3rd)
            sinogram_imag(j, i) = imag(ff_spectrum(h)); 
        end
    end
    
    % Image Reconstruction using Inverse Radon Transform (iradon)
    % Parameters: 'spline' interpolation, 'none' filter, 1 for output size, FOV for number of slices
    img_raw_imag = iradon(sinogram_imag, ang_seq,"spline","ram-lak" ,1, FOV);    % reconstructed algorithm iradon
    img_reconstructed_imag = rot90(-img_raw_imag,2);    % system correction of image position
    % Progress reporting and performance check
    if mod(n, 10) == 0 || n == N_phantoms
        elapsed_time = toc;
        fprintf('  Processing phantom %d/%d (%.2f%% complete), current time: %.4f s\n', ...
            n, N_phantoms, n/N_phantoms*100, elapsed_time);
    end
    img_simulated_imag = imresize(img_reconstructed_imag,[49,49]);              % image size transformation
    sinogram_imag = sinogram_imag * transfer_coeffcient(HARMONICS-1);           % transfer function correction
    img_simulated_imag = img_simulated_imag * transfer_coeffcient(HARMONICS-1); % transfer function correction
    img_simulated_imag = img_simulated_imag + noise;                            % noise addition
end

%% **Phase 3: Visualization and Output**
% -------------------------------------
run("Visualization_2.m")
