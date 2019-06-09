classdef OdeSolver < Solver
    % ODESOLVER Solves an ODE using the built-in ODE solving suite
    %   (ode45, and ode113 for ultra-low tolerances)
    
    properties
        tolerance    % Relative tolerance for the ODE solver
    end
    
    methods
        function obj = OdeSolver(t_final, t_resolution, tolerance)
            % ODESOLVER(T_FINAL, T_RESOLUTION, TOLERANCE)
            %   Construct an instance of this class
            %
            %   t_final is the final time to simulate to
            %   t_resolution is the time-step size
            %   tolerance is the relative tolerance for the ODE solver
            
            obj = obj@Solver(t_final, t_resolution);
            obj.tolerance = tolerance;
        end
    end
    
    methods
        results = solve(obj, hamiltonian, psi0, output_fnames, ...
            output_funhandles);
    end
    
    methods(Static)
        output_fcn = create_scalar_output_fcn(fieldnames, calc_scalars, ...
            vectorize);
        vect_measurement_fcn = vectorize_measurement(measurement_fcn);
    end
end

