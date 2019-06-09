classdef(Abstract) Solver < handle
    % SOLVER Solves an ODE through some time-stepping scheme.
    
    properties
        t_final      % Final time value to simulate to
        t_resolution % Time-step size
    end
    
    methods
        function obj = Solver(t_final, t_resolution)
            % SOLVER(T_FINAL, T_RESOLUTION)
            %   Construct an instance of this class
            %
            %   t_final is the final time to simulate to
            %   t_resolution is the time-step size
            obj.t_final = t_final;
            obj.t_resolution = t_resolution;
        end
    end
    
    methods(Abstract)
        % Simulate under the given hamiltonian and initial state, calculate
        % outputs at each time step from the given functions, and return a
        % SolverResults instance containing the calculations.
        results = solve(hamiltonian, psi0, output_fnames, ...
            output_funhandles);
    end
end

