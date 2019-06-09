classdef TransInvtSim < Simulator
    % TRANSINVTSIM Calculates extensive properties through some
    %   time-stepping simulation scheme of a translationally invariant
    %   state vector and Hamiltonian.
    
    methods(Access = protected)
        [system_displacements, measurement_displacements] = ...
            get_displacements_for_prop_calculation(obj, rectangle_size);
        measurement_displacements = ...
            get_measurement_displacements_for_single_sim(obj, ...
            rectangle_size, system_displacement);
    end
end
