classdef UniformSpinState < StateFactory
    % UNIFORMSPINSTATE State factory for uniform product state of spins
    % in the computational (Sz) basis.
    %
    % The state vector is given by the direct product:
    %   (x) [exp(-i*phi/2)*cos(theta/2)|+> + exp(i*phi/2)*sin(theta/2)|->]
    
    properties
        theta % polar angle on the Bloch sphere
        phi % azimuthal angle on the Bloch sphere
    end
    
    methods
        function obj = UniformSpinState(theta, phi)
            % UNIFORMSPINSTATE(THETA, PHI)
            % Construct an instance of this class.
            % 
            % theta is the polar angle on the Bloch sphere.
            % phi is the azimuthal angle on the Bloch sphere (default 0).
            if nargin < 2
                phi = 0;
            end
            
            obj.theta = theta;
            obj.phi = phi;
        end
        
        state_vector = make_state(obj, rectangle_size, system_displacement);
    end
end

