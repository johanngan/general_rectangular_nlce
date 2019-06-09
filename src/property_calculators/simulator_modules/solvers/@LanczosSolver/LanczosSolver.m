classdef LanczosSolver < Solver
    % LANCZOSSOLVER Solves an ODE using the Lanczos method
    
    properties
        basis_size    % Number of Lanczos basis vectors to use
        n_time_steps
        % Minimum number of components in the full state space for the
        % actual Lanczos stepper to be used, otherwise defaults to an
        % OdeSolver instead.
        min_full_basis_size
        % Tolerance for the OdeSolver for small full basis sizes
        odesolver_tolerance
        
        extra_precision     % For rounding when calculating time step size
    end
    
    properties(Dependent)
        time_step_size
    end
    
    methods
        function obj = LanczosSolver(t_final, t_resolution, basis_size, ...
                odesolver_tolerance, n_time_steps, min_full_basis_size)
            % LANCZOSSOLVER(T_FINAL, T_RESOLUTION, BASIS_SIZE,
            %   ODESOLVER_TOLERANCE, N_TIME_STEPS, MIN_FULL_BASIS_SIZE)
            %   Construct an instance of this class
            %
            %   t_final is the final time to simulate to
            %   t_resolution is the time-step size
            %   basis_size is the number of Lanczos basis vectors to use
            %   odesolver_tolerance is the tolerance for the OdeSolver for
            %   small full basis sizes
            %   n_time_steps is the number of Lanczos time steps to use
            %   Defaults to 1.
            %   min_full_basis_size is the minimum number of components in
            %   the full state space for the actual Lanczos stepper to be
            %   used, otherwise defaults to an OdeSolver instead.
            if nargin < 6
                min_full_basis_size = 2^10;
            end
            if nargin < 5
                n_time_steps = 1;
            end
            
            obj = obj@Solver(t_final, t_resolution);
            obj.basis_size = basis_size;
            obj.odesolver_tolerance = odesolver_tolerance;
            obj.n_time_steps = n_time_steps;
            obj.min_full_basis_size = min_full_basis_size;
            
            obj.extra_precision = 2;
        end
        
        function time_step_size = get.time_step_size(obj)
            % A bit more precise than the order of magnitude of the final
            % time
            precision = round(log10(obj.t_final)) + obj.extra_precision;
            time_step_size = obj.t_final / obj.n_time_steps;
            time_step_size = ceil(time_step_size * 10^precision) ...
                / 10^precision;
        end
    end
    
    methods
        results = solve(obj, hamiltonian, psi0, output_fnames, ...
            output_funhandles);
    end
    
    methods(Access = private)
        V = generate_basis(obj, hamiltonian, v0);
        [h, Q] = generate_lanczos_h(obj, hamiltonian, v0);
        [outputs, psi] = lanczos_step(obj, hamiltonian, psi0, tvals, ...
            output_funhandles)
        [outputs, step_boundary_times] = lanczos_solve(obj, ...
            hamiltonian, psi0, tvals, output_funhandles, dt);
    end
    
    methods(Static, Access = private)
        v = generate_next_basis_vec(hamiltonian, V, m);
    end
end

