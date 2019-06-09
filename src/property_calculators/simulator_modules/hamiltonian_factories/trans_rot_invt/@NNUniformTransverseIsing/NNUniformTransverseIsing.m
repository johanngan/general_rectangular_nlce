classdef NNUniformTransverseIsing < HamiltonianFactory
    % NNUNIFORMTRANSVERSEISING Creates action function for the Hamiltonian
    % of the Ising model with uniform nearest-neighbor interactions and a
    % uniform transverse field.
    %
    % H = -J*sum(Szi*Szj) - h*sum(Sxi)
    % where J is the interaction strength and h is the transverse field
    
    properties
        interaction_strength
        transverse_field
    end
    
    methods
        function obj = NNUniformTransverseIsing(...
                interaction_strength, transverse_field)
            % NNUNIFORMTRANSVERSEISING(
            %   INTERACTION_STRENGTH, TRANSVERSE_FIELD)
            %   Construct an instance of this class.
            obj.interaction_strength = interaction_strength;
            obj.transverse_field = transverse_field;
        end
        
        hamiltonian = make_hamiltonian(obj, rectangle_size, ...
            system_displacement);
    end
end
