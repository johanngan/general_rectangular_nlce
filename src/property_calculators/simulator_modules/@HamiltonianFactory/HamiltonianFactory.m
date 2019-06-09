classdef(Abstract) HamiltonianFactory < handle
    % HamiltonianFactory Creates Hamiltonian action functions.
    
    methods(Abstract)
        % Makes a Hamiltonian action function for a given rectangle size,
        % displaced in space by a certain amount. The output is a
        % function handle that takes in a time value and state vector, and
        % returns a new state vector made by acting the Hamiltonian on the
        % input state vector.
        hamiltonian = make_hamiltonian(obj, rectangle_size, ...
            system_displacement);
    end
end
