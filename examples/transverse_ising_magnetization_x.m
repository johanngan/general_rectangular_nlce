%%%%%%%%%%%%%%%%%%%%%%
% PARAMS

% NLCE
nlce_order = 16;

% Simulation
t_final = 1;
t_resolution = 1e-2;
tolerance = 1e-7;

% Hamiltonian
interaction_strength = 1;
transverse_field = 1;

% Initial state
polar_angle = 0;

% Progress printing
verbose = true;

% Caching/Output
% For rectangle enumeration
short_enumstorefile = 'enumerators/weights_map_O2.txt';

% For property calculation
short_propstorepath = 'property_calculators/transverse_ising_magnetization_x';

% For NLCE output
short_outfile = 'output/transverse_ising_magnetization_x.txt';

%%%%%%%%%%%%%%%%%%%%%%
% SETUP

solver = OdeSolver(t_final, t_resolution, tolerance);
measurement = @sum_magnetization_x;
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
magnetization_x = nlce_calc.calc_nlce(nlce_order, ...
    fullfile(STOREROOT, short_outfile), verbose);
plot(tvals, magnetization_x);
title('<S_x> over time');
xlabel('t');
ylabel('<S_x>');
