% Startup script. Run to set up the MATLAB for rectangular NLCE calculation.
addpath(genpath(fullfile(pwd, 'src')));
addpath(genpath(fullfile(pwd, 'vendor')));

% Path of the root data store directory, for convenience
STOREROOT = fullfile(pwd, 'store');