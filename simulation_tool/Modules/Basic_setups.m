%% **Basic Simulation Parameters Setup for FFL-MPI**
% Defines fundamental physical constants, magnetic particle properties, 
% magnetic field configurations, and data acquisition settings.

% Define global variables only if strictly necessary for other scripts (e.g., Models)
global mu0 kB T m beta

tic % Start timing the setup process

%% 1 - Fundamental Physical Constants
% Standard physical constants used in the models.
mu0 = 4*pi*10^(-7);    % Permeability of free space [T*m/A] or [H/m]
kB = 1.380649e-23;     % Boltzmann constant [J/K]
T = 293.15;            % Absolute Temperature (e.g., room temperature) [K]

%% 2 - Magnetic Particle Parameters (SPIOs)
% Parameters for SPIOs.
D = 70e-9;             % Magnetic core diameter [m]
V = 1/6 * pi * D^3;    % volume of particle
Ms = 3e4;
m = V * Ms;            % Effective magnetic moment per particle [A*m^2]

% Langevin Parameter (used in Langevin Model)
beta = m * mu0 / (kB * T); 

%% 3 - Model Selection
% Select the magnetic particle magnetization model for the forward calculation.
% - model = 0: Langevin Model (Ideal, static)
% - model = ... developling
MODEL_SELECTION = 0;
transfer_coeffcient = [0.0021, 0.1142, 9e-4, -0.0287, -6.27e-4, 0.0109]; % transfer function clibration coeffcient
%% 4 - Field-of-View (FOV) and Spatial Domain Parameters
% Define the spatial grid and FOV for projection imaging.
FOV_PIXELS = 100;               % FOV size in pixels (Reconstruction resolution)
FOV_LENGTH_METER = 20e-3;      % Total extent of the FOV in meters (e.g., 20 mm)

% 1D spatial domain definition for projection line
x = linspace(-FOV_LENGTH_METER/2, FOV_LENGTH_METER/2, FOV_PIXELS); % 1D projection domain [m]

%% 5 - Magnetic Field Parameters
% Define the Selection Field (SF), Focus Field (FF), and Excitation Field (DF) parameters.

% Selection Field (SF) / Gradient
G = 1.6;                       % Selection field gradient magnitude [T/m]

% Focus Field (FF) / Offset Field (A low-frequency sweeping field)
Af = max(x) * G;               % Amplitude of Focus field (calculated from max FOV extent) [T]
ff = 1;                        % Frequency of Focus field [Hz]

% Excitation Field (DF) / Drive Field
As = 3.2e-3;                     % Amplitude of excitation field [T]
fd = 3.0e3;                    % Frequency of excitation field [Hz]

%% 6 - Sampling and Acquisition Parameters (ADC)
% Define the parameters for the Analog-to-Digital Converter (ADC).
Fs = 3e6;                    % Sampling rate [Hz]
Time = 1;                      % Total acquisition time [s]
t = 1/Fs:1/Fs:Time;            % Sampling time points vector [s]

% Angle Sequence for Projection Imaging
ANGLE_STEP_DEG = 6;            % Step size for rotation angle [degrees]
ang_seq = 0:ANGLE_STEP_DEG:180;% Rotation angle sequence vector [degrees]

%% 7 - Harmonic Selection for Reconstruction
% Define the range and specific harmonic used for image reconstruction.
% 'h' is the index of the desired harmonic in the FFT spectrum.
HARMONICS = 7;                                      % HARMONICS is the harmonic you want to output, for example 3rd

partial_FOV_length = floor(Fs / FOV_PIXELS);        % Number of sampling points per spatial pixel
f_resolution = Fs/partial_FOV_length;               % Frequency resolution
HARMONICS_INDICES = (1:7)*fd/f_resolution+1;        % 1~7 harmonics extracted with +1 of DC bias
HARMONIC_INDEX = HARMONICS_INDICES(HARMONICS-1);    % Select the HARMONICS and make the HARMONIC_INDEX

%% 8 - Cleanup and Reporting
% Map variables used by subsequent files to their new names
FOV = FOV_PIXELS;
model = MODEL_SELECTION;
h = HARMONIC_INDEX;

fprintf("Basic simulation parameters setup complete. Time elapsed: %f s\n", toc);