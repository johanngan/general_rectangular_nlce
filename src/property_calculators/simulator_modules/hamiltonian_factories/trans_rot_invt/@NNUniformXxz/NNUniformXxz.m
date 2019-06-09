classdef NNUniformXxz < HamiltonianFactory
    % NNUNIFORMXXZ Creates action function for the Hamiltonian
    % of the XXZ model with uniform nearest-neighbor interactions
    %
    % H = -Jz*sum(Szi*Szj) - Jp*sum(Sxi*Sxj + Syi*Syj)
    % where Jz is the parallel interaction strength and Jp is the
    % perpendicular interaction strength.
    
    properties
        par_interaction_strength
        perp_interaction_strength
    end
    
    methods
        function obj = NNUniformXxz(...
                par_interaction_strength, perp_interaction_strength)
            % NNUNIFORMXXZ(
            %   PAR_INTERACTION_STRENGTH, PERP_INTERACTION_STRENGTH)
            %   Construct an instance of this class.
            obj.par_interaction_strength = par_interaction_strength;
            obj.perp_interaction_strength = perp_interaction_strength;
        end
        
        hamiltonian = make_hamiltonian(obj, rectangle_size, ...
            system_displacement);
    end
end
