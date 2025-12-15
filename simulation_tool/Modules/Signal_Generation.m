%% **Magnetic Particle Signal Generation**
% Calculates the time-domain magnetization M(t, x) and the corresponding 
% Differential Magnetization dM(t, x) for all spatial pixels.

% Input variables:
% - model: Particle magnetization model selection (0: Langevin, 1/2: MJA)
% - mu0, m, beta: Physical constants and particle properties
% - H: Total magnetic field H(t, x) calculated in A/m

tic % Start timing for signal generation

% Initialize Magnetization matrix M. The size is [length(t) x FOV]
M = zeros(size(H), 'single'); 

%% 1 - Compute Magnetization M(t, x) based on Model Selection
% The magnetization M is calculated in [T * (A*m^2)] or equivalent [Wb*m].
% Note: The final MPI signal is proportional to dM/dt.

if model == 0 % **Langevin Model**
    
    % M = mu0 * m * L(beta * H) 
    % L(x) is the Langevin function.
    % The negative sign is likely for aligning the convention of the output M
    M = single(-mu0 * m * langevin(beta * H));
    fprintf(' Using Langevin Model for Magnetization calculation.\n');

elseif model == 1
    fprintf(' New model is in the development phase..\n');
end
%% 2 - Compute Differential Magnetization (dM)
% The MPI voltage signal U(t) is proportional to dM/dt (Faraday's Law).
% dM is the system matrix (SM) kernel in the time domain.
% We use the 'gradient' function to approximate the time derivative (dM/dt).

% dM/dt is approximated as gradient(M) along the time dimension (dimension 1).
% The output dM matrix size remains [length(t) x FOV].
% dM = single(gradient(M, 1))*9e25 + repmat(noise,[1,size(M,2)]); 
dM = single(gradient(M, 1))*1e23;

clear M H
fprintf("Signal generation (dM) complete. Time elapsed: %f s\n", toc);