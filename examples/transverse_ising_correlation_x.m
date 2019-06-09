%%%%%%%%%%%%%%%%%%%%%%
% PARAMS

% NLCE
nlce_order = 12;
r_sep = [1, 1];

% Simulation
t_final = 1;
t_resolution = 1e-2;
tolerance = 1e-7;

% Hamiltonian
interaction_strength = 1;
transverse_field = 1;

% Initial state
polar_angle = pi/2;

% Progress printing
verbose = true;

% Caching/Output
% For rectangle enumeration
short_enumstorefile = 'enumerators/weights_map_O2.txt';

% For property calculation
short_propstorepath = 'property_calculators/transverse_ising_correlation_x';

% For NLCE output
short_outfile = 'output/transverse_ising_correlation_x.txt';

%%%%%%%%%%%%%%%%%%%%%%
% SETUP

% Force the measurement to be rotationally invariant: if r_sep = [x, y],
% where x != y, average it with the measurement with r_sep = [y, x].
% This is equivalent to just computing r_sep = [x, y] separately on all
% rectangles because each rectangle has a symmetric partner (or is
% symmetric itself).
if r_sep(1) == r_sep(2)
    measurement = @(psi, rectangle_size, measurement_displacement) ...
        sum_spin_covariance_x(psi, rectangle_size, ...
        measurement_displacement, r_sep);
else
    measurement = @(psi, rectangle_size, measurement_displacement) ...
        covx_symm(psi, rectangle_size, measurement_displacement, r_sep);
end


solver = OdeSolver(t_final, t_resolution, tolerance);
hamiltonian_factory = NNUniformTransverseIsing(...
    interaction_strength, transverse_field);
initial_state_factory = UniformSpinState(polar_angle);
storepath = fullfile(STOREROOT, short_propstorepath);

prop_calc = TransRotInvtSim(solver, measurement, hamiltonian_factory, ...
    initial_state_factory, storepath);
prop_calc.flush_store(true, true);    % Force the flush quietly

enumerator = O2Enumerator(fullfile(STOREROOT, short_enumstorefile));
nlce_calc = NlceCalculator(prop_calc, enumerator, Writer);

%%%%%%%%%%%%%%%%%%%%%%
% COMPUTATION

tvals = 0:t_resolution:t_final;
correlation_x = nlce_calc.calc_nlce(nlce_order, ...
    fullfile(STOREROOT, short_outfile), verbose);

subplot(1, 2, 1);
plot(tvals, correlation_x);
title(sprintf('C_x(%i, %i) over time', r_sep(1), r_sep(2)));
xlabel('t');
ylabel(sprintf('C_x(%i, %i)', r_sep(1), r_sep(2)));

subplot(1, 2, 2);
loglog(tvals, correlation_x);
title(sprintf('C_x(%i, %i) over time', r_sep(1), r_sep(2)));
xlabel('t');
ylabel(sprintf('C_x(%i, %i)', r_sep(1), r_sep(2)));


% Symmetrize the covariance measurement
function covx = covx_symm(psi, rectangle_size, ...
    measurement_displacement, r_sep)
    covx = sum_spin_covariance_x(psi, rectangle_size, ...
        measurement_displacement, r_sep);
    if rectangle_size(1) ~= rectangle_size(2)
        % Average with the symmetric partner r_sep if it's distinct
        covx = covx + sum_spin_covariance_x(psi, rectangle_size, ...
            measurement_displacement, flip(r_sep));
        covx = covx / 2;
    end
end
