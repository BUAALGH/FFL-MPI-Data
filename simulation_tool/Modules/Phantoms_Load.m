%% **Phase 1: Load Digital Phantoms (MNIST) and Generate Projections**
% Loads MNIST images and converts them into 1D projection profiles 
% (sinograms) for the FFL-MPI simulation.

% Note: Variables FOV (FOV_PIXELS) and ang_seq (Rotation angle sequence) 
% are loaded from Basic_setups.m

tic % Start timing for phantom loading

% 1. Load Data and Noise
filename = sprintf('noise_k_%d.mat', HARMONICS);
load(filename)

load('Dataset\train_images.mat');  % Load the MNIST dataset (e.g., 28x28 images)
load phantom_3.mat                   % loading the example phantom
% the example phantom size is [100, 100], and output reconstructed image
% size is [49,49], we use imresize function for this size transformation.
% that is image = imresize(phantom, [49, 49]), the parameters of imresize
% function is set as default.
train_images = phantom_3;   % change the data type of phantom, if you have multiple phantoms
% you can intergrate them into phantom as [m,m,n] where m is the image size
% and n is the phantom numbers
tmp_image = imresize(train_images(:,:,1),[FOV_PIXELS,FOV_PIXELS]); % normalize the phantom size, because your input phanotm
% may be different the standard size of this simulation framework

% Get the total number of images (phantoms)
[~, ~, N_phantoms_total] = size(train_images);
% Determine necessary dimensions
L_projection = FOV;          % Target length of the cropped projection (e.g., 30 pixels)
N_angles = length(ang_seq);  % Number of projection angles

% 2. Calculate Centered Cropping Indices
% Compute the size of the full sinogram for an M x M image (e.g., 28x28)
% Note: We use the first image to determine the initial sinogram size.
L_original = size(radon(tmp_image, ang_seq), 1);

% Calculate the margin needed to center the L_projection (e.g., 30) within L_original (e.g., 41)
crop_margin = (L_original - L_projection) / 2; 

% Determine the start and end row indices for the cropped FOV
START_ROW = round(crop_margin);
END_ROW = START_ROW + L_projection-1;

% 3. Pre-allocate the Phantoms Matrix for efficiency
phantoms = zeros(L_projection, N_angles, N_phantoms_total, 'single');

% 4. Loop through images to generate projection phantoms
fprintf('  Starting projection generation for %d phantoms...\n', N_phantoms_total);

for i = 1:N_phantoms_total
    % Extract the current MNIST image
    img = train_images(:,:,i)/255; 
    img = imresize(img,[FOV_PIXELS,FOV_PIXELS]);
    % Compute the Radon Transform (Projection)
    sinogram_full = radon(img, ang_seq);
    
    % Crop the projection to the defined FOV length (L_projection)
    % This extracts the central, relevant region corresponding to the MPI FOV.
    sinogram_cropped = sinogram_full(START_ROW:END_ROW, :);
    
    % Store the processed phantom
    phantoms(:,:,i) = sinogram_cropped;
    
    % Progress reporting
    if mod(i, 1000) == 0 || i == N_phantoms_total
        fprintf('  Loaded %d/%d phantoms (%.2f%% complete).\n', ...
            i, N_phantoms_total, i/N_phantoms_total*100);
    end
end

% 5. Cleanup and Reporting
clear train_images; % Clear the large temporary variable to free up memory

fprintf("Phase 1 complete: %d MNIST dataset phantoms loaded and projected. Time elapsed: %f s\n", N_phantoms_total, toc);