%% **Visualization of FFL-MPI Projection and Reconstructed Image**
% Assumes the last processed phantom (n) and its results are used.

% Ensure the figure is visible and set a large size for presentation quality
figure('Name', sprintf('FFL-MPI Results for Phantom %d', n), ...
       'Position', [100, 100, 2000, 1200]); % Increased height for 2 rows

% Set default font size for better readability in reports
set(gca, 'FontSize', 16); 

%% --- Column 1: Simulated Sinogram (Harmonic Data) ---
% Subplot 1: Sinogram Image
subplot(2, 3, 1)
img1 = imresize(sinogram_imag(:,:,n), size(img_simulated_imag));
imagesc(img1)
axis equal; 
axis tight;
colormap("gray");

% Set box line width to 1.5
set(gca, 'LineWidth', 1.5, 'FontSize', 16);

% Add colorbar with descriptive label
c = colorbar;
c.Label.String = sprintf('Imaginary Part of Sinogram (a.u.)');
c.Label.FontSize = 16; % Set colorbar label font size
c.FontSize = 14; % Set colorbar tick font size

% Set colorbar box line width
set(c, 'LineWidth', 1.5);

% Set axes labels
xlabel('Projection Angle Index', 'FontSize', 16);
ylabel('Spatial Pixel Index', 'FontSize', 16);

% Add a descriptive title
title(sprintf('Simulated Sinogram (Phantom %d, Harmonic %d)', n, HARMONICS), 'FontWeight', 'bold', 'FontSize', 16);

% Subplot 4: Histogram of Sinogram
subplot(2, 3, 4)
% Flatten the image data for histogram
img1_data = img1(:);
% Calculate histogram
[counts, binCenters] = histcounts(img1_data, 32);
binEdges = binCenters(1:end-1) + diff(binCenters)/2;
% Plot histogram
bar(binEdges, counts, 'FaceColor', [0.5 0.5 0.5], 'EdgeColor', 'k', 'LineWidth', 1.5);
xlabel('Pixel Intensity (a.u.)', 'FontSize', 16);
ylabel('Frequency', 'FontSize', 16);
title('Sinogram Histogram', 'FontSize', 16, 'FontWeight', 'bold');
grid on;
xlim([min(img1_data), max(img1_data)]);

% Set box line width to 1.5 and font size
set(gca, 'LineWidth', 1, 'FontSize', 16);

%% --- Column 2: Reconstructed MPI Image ---
% Subplot 2: Reconstructed Image
subplot(2, 3, 2)
img2 = img_simulated_imag(:,:,n);
imagesc(img2)
axis equal; 
axis tight;
colormap("gray");

% Set box line width to 1.5 and font size
set(gca, 'LineWidth', 1.5, 'FontSize', 16);

% Add colorbar with descriptive label
c = colorbar;
c.Label.String = 'Reconstructed Particle Concentration (a.u.)';
c.Label.FontSize = 16; % Set colorbar label font size
c.FontSize = 14; % Set colorbar tick font size

% Set colorbar box line width
set(c, 'LineWidth', 1.5);

% Set axes labels
xlabel('Spatial X-Coordinate (pixels)', 'FontSize', 16);
ylabel('Spatial Y-Coordinate (pixels)', 'FontSize', 16);

% Add a descriptive title
title(sprintf('Reconstructed FFL-MPI Image (Phantom %d, Harmonic %d)', n, HARMONICS), 'FontWeight', 'bold', 'FontSize', 16);

% Subplot 5: Histogram of Reconstructed Image
subplot(2, 3, 5)
% Flatten the image data for histogram
img2_data = img2(:);
% Calculate histogram
[counts, binCenters] = histcounts(img2_data, 32);
binEdges = binCenters(1:end-1) + diff(binCenters)/2;
% Plot histogram
bar(binEdges, counts, 'FaceColor', [0.5 0.5 0.5], 'EdgeColor', 'k', 'LineWidth', 1.5);
xlabel('Pixel Intensity (a.u.)', 'FontSize', 16);
ylabel('Frequency', 'FontSize', 16);
title('Reconstructed Image Histogram', 'FontSize', 16, 'FontWeight', 'bold');
grid on;
xlim([min(img2_data), max(img2_data)]);

% Set box line width to 1.5 and font size
set(gca, 'LineWidth', 1, 'FontSize', 16);

%% --- Column 3: Noise Background ---
% Subplot 3: Noise Image
subplot(2, 3, 3)
img3 = noise(:,:,n);
imagesc(img3)
axis equal; 
axis tight;
colormap("gray");

% Set box line width to 1.5 and font size
set(gca, 'LineWidth', 1.5, 'FontSize', 16);

% Add colorbar with descriptive label
c = colorbar;
c.Label.String = 'Noise Background (a.u.)';
c.Label.FontSize = 16; % Set colorbar label font size
c.FontSize = 14; % Set colorbar tick font size

% Set colorbar box line width
set(c, 'LineWidth', 1.5);

% Set axes labels
xlabel('Spatial X-Coordinate (pixels)', 'FontSize', 16);
ylabel('Spatial Y-Coordinate (pixels)', 'FontSize', 16);

% Add a descriptive title
title(sprintf('Noise Background (Harmonic %d)', HARMONICS), 'FontWeight', 'bold', 'FontSize', 16);

% Subplot 6: Histogram of Noise Background
subplot(2, 3, 6)
% Flatten the image data for histogram
img3_data = img3(:);
% Calculate histogram
[counts, binCenters] = histcounts(img3_data, 32);
binEdges = binCenters(1:end-1) + diff(binCenters)/2;
% Plot histogram
bar(binEdges, counts, 'FaceColor', [0.5 0.5 0.5], 'EdgeColor', 'k', 'LineWidth', 1.5);
xlabel('Pixel Intensity (a.u.)', 'FontSize', 16);
ylabel('Frequency', 'FontSize', 16);
title('Noise Histogram', 'FontSize', 16, 'FontWeight', 'bold');
grid on;
xlim([min(img3_data), max(img3_data)]);

% Set box line width to 1.5 and font size
set(gca, 'LineWidth', 1, 'FontSize', 16);

currentTime = datestr(now, 'yyyy-mm-dd');

sgtitle('FFL-MPI Projection Imaging Simulation Framework: Simulation Results', ...
        'FontSize', 24, 'FontWeight', 'bold');
    annotation('textbox', [0.1, 0.01, 0.8, 0.03], ...
    'String', sprintf('Date: %s    |    Developers: Guanghui Li, Haicheng Du    |    Affiliation: Beihang University', currentTime), ...
    'FontSize', 16, ...
    'FontWeight', 'normal', ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'middle', ...
    'LineStyle', 'none', ...
    'BackgroundColor', [0.95 0.95 0.95], ...
    'Margin', 5, ...
    'FitBoxToText', 'on');
set(gcf, 'Color', 'white');
