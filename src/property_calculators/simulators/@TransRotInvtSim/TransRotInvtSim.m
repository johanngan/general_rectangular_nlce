classdef TransRotInvtSim < TransInvtSim
    % TRANSROTINVTSIM Calculates extensive properties through some
    %   time-stepping simulation scheme of a translationally and
    %   rotationally invariant state vector and Hamiltonian.
    
    methods(Access = protected)
        rectangle_size = symmetry_transform(obj, rectangle_size);
    end
end
