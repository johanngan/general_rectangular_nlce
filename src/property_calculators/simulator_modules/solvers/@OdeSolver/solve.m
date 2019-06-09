function results = solve(obj, hamiltonian, psi0, output_fnames, ...
    output_funhandles)
    % Runs a time-evolution simulation under given parameters.
    %   - hamiltonian is function handle (t, psi) of the Hamiltonian
    %       action, used by the ODE solver
    %   - psi0 is the initial state vector (column)
    %   - output_fnames is a cell array corresponding to output_funhandles
    %       with the names of each measurement, to specify the fieldnames
    %       in the SolverResults output structure.
    %   - output_funhandles is a cell array of output function handles
    %       that take in (psi) and output a measurement
    
    ode_fn = @ode45;
    if obj.tolerance <= 1e-8
        ode_fn = @ode113;
    end
    
    rel_tol = obj.tolerance;
    % Lower limit on the actual relative tolerance used
    tol_limit = 100*eps();
    if rel_tol <= tol_limit
        rel_tol = tol_limit;
    end
    
    % Form the time derivative from the Hamiltonian
    f = @(t, y) -1i*hamiltonian(t, y);
    
    % Set up the output function
    output_fcn = OdeSolver.create_scalar_output_fcn(output_fnames, ...
        output_funhandles);

    % Set up the SolverResults and run the solver under the specified
    % conditions
    results = SolverResults();
    ode_fn(f, 0:obj.t_resolution:obj.t_final, psi0, ...
        odeset('RelTol', rel_tol, ...
            'AbsTol', obj.tolerance, ...
            'Vectorized', 'on', ...
            'OutputFcn', @(t, y, flag) output_fcn(t, y, flag, results)));
    % At this point, the results instance will have been mutated to hold
    % the simulation results.
end
