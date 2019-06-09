% TODO

classdef PowerLawRampedFieldIsing < HamiltonianFactory
    % POWERLAWRAMPEDFIELDISING Creates action function for the
    % Hamiltonian of the Ising model with power-law interactions with
    % ramped transverse and longitudinal fields, as described in this
    % paper:
    %   https://journals.aps.org/prx/abstract/10.1103/PhysRevX.8.021069
    
    properties
        rabi_frequency_initial      % Omega_min
        rabi_frequency_final        % Omega_max
        rabi_frequency_ramp_time    % t_r
        
        detuning_initial   % Delta_i
        detuning_final     % Delta_f
        detuning_ramp_time % t_s
        
        interaction_coefficient % C
        interaction_power       % alpha - assumed nonnegative to be physical
        lattice_spacings        % Vector of lattice spacings [dx, dy]
        
        neighbor_rank_limit % Highest-order neighbor interactions to include
    end
    
    methods
        function obj = PowerLawRampedFieldIsing(...
                rabi_frequency_initial, ...
                rabi_frequency_final, ...
                rabi_frequency_ramp_time, ...
                detuning_initial, ...
                detuning_final, ...
                detuning_ramp_time, ...
                interaction_coefficient, ...
                interaction_power, ...
                lattice_spacings, ...
                neighbor_rank_limit...
                )
            % POWERLAWRAMPEDFIELDISING(
            %   RABI_FREQUENCY_INITIAL, RABI_FREQUENCY_FINAL,
            %   RABI_FREQUENCY_RAMP_TIME, DETUNING_INITIAL,
            %   DETUNING_FINAL, DETUNING_RAMP_TIME,
            %   INTERACTION_COEFFICIENT, INTERACTION_POWER,
            %   LATTICE_SPACINGS, NEIGHBOR_RANK_LIMIT)
            %   Construct an instance of this class.
            obj.rabi_frequency_initial = rabi_frequency_initial;
            obj.rabi_frequency_final = rabi_frequency_final;
            obj.rabi_frequency_ramp_time = rabi_frequency_ramp_time;
            obj.detuning_initial = detuning_initial;
            obj.detuning_final = detuning_final;
            obj.detuning_ramp_time = detuning_ramp_time;
            obj.interaction_coefficient = interaction_coefficient;
            obj.interaction_power = interaction_power;
            obj.lattice_spacings = lattice_spacings;
            obj.neighbor_rank_limit = neighbor_rank_limit;
        end
        
        hamiltonian = make_hamiltonian(obj, rectangle_size, ...
            system_displacement);
    end
    
    methods(Access = private)
        interaction = calc_interaction(obj, distance);
        omega = rabi_frequency(obj, time);
        delta = detuning(obj, time);
    end
end
