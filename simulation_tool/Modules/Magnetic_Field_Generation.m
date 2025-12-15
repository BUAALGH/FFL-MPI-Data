%% **Magnetic Field Generation for FFL-MPI Simulation**
% Calculates the total magnetic field H(t, x) across the FOV by combining 
% the Drive Field (DF), Focus/Offset Field (FF), and Selection Field (SF).
% The total field H is calculated in A/m.

% Note: Variables mu0, t, FOV, x, G, As, Af, ff, fd are loaded from Basic_setups.m

%% 1 - Selection Field (SF) - Spatial Component
% B_selection(x) = G * x
B_selection_spatial = G * x;         % Selection Field (SF) in the spatial domain [T]
H_selection_spatial = B_selection_spatial / mu0; % Convert to H-field [A/m]

% Replicate the spatial H-field across all time points
H_selection = repmat(H_selection_spatial, [length(t), 1]); % Size: [length(t) x FOV]
H_selection = single(H_selection);

%% 2 - Drive Field (DF) - Temporal Component
% B_drive(t) = As * sin(2*pi*fd*t)
B_drive_temporal = As * sin(2 * pi * fd * t); % Sinusoidal Drive Field component [T]

%% 3 - Focus/Offset Field (FF) - Temporal Component?
% B_focus(t) = Linear ramp for FFL sweeping (Simulated by linspace)
% The linear ramp is used to simulate the slow sweep of the Field-Free Line (FFL) across the FOV.
B_focus_temporal = linspace(-Af, Af, length(t)); % Low-frequency linear sweep component [T]

%% 4 - Total Drive and Focus Field (Combined Temporal Field)
% B_DF(t) = B_drive(t) + B_focus(t)
B_DF_temporal = B_drive_temporal + B_focus_temporal; % Combined temporal B-field [T]
H_DF_temporal = B_DF_temporal / mu0;                 % Convert to H-field [A/m]
H_DF_temporal = single(H_DF_temporal);               % Convert to signle data type

% Replicate the temporal H-field across all spatial pixels (FOV)
H_DF = repmat(H_DF_temporal', [1, FOV]); % Size: [length(t) x FOV]
H_DF = single(H_DF);

%% 5 - Total Magnetic Field H(t, x)
% H(t, x) = H_DF(t, x) + H_selection(t, x)
% The final total magnetic field acting on the magnetic particles at all time-spatial points.
H_total = H_DF + H_selection;
H_total = single(H_total);

% Map H_total to the final variable H used by Signal_Generation.m
H = H_total;

clear t B_selection_spatial B_DF_temporal B_drive_temporal B_focus_temporal H_DF_temporal H_selection H_selection_spatial H_total H_DF
fprintf("2 magnetic fields (H_DF and H_selection) generated and combined into H_total. Time elapsed: %f s\n", toc);