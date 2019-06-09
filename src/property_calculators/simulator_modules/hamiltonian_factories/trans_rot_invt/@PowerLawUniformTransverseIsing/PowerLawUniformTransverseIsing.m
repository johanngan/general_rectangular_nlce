classdef PowerLawUniformTransverseIsing < HamiltonianFactory
    % POWERLAWUNIFORMTRANSVERSEISING Creates action function for the
    % Hamiltonian of the Ising model with uniform power-law interactions
    % and a uniform transverse field.
    %
    % H = -sum(Jij*Szi*Szj) - h*sum(Sxi)
    % where Jij = C/dij^alpha is the interaction strength between sites i
    % and j, and h is the transverse field. The grid spacing (distance
    % between nearest neighbor sites) is assumed to be 1. If some other
    % grid spacing is desired, absorb it into the interaction coefficient
    % C.
    
    properties
        interaction_coefficient % C
        interaction_power       % alpha
        transverse_field        % h
    end
    
    methods
        function obj = PowerLawUniformTransverseIsing(...
                interaction_coefficient, interaction_power, transverse_field)
            % POWERLAWUNIFORMTRANSVERSEISING(
            %   INTERACTION_COEFFICIENT, INTERACTION_POWER, TRANSVERSE_FIELD)
            %   Construct an instance of this class.
            obj.interaction_coefficient = interaction_coefficient;
            obj.interaction_power = interaction_power;
            obj.transverse_field = transverse_field;
        end
        
        hamiltonian = make_hamiltonian(obj, rectangle_size, ...
            system_displacement);
    end
    
    methods(Access = private)
        interaction = calc_interaction(obj, distance);
    end
end
