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
    
    if length(psi0) >= obj.min_full_basis_size
        % Set up the SolverResults and run the solver under the specified
        % conditions
        results = SolverResults();
        results.data.t = (0:obj.t_resolution:obj.t_final).';
        outputs = obj.lanczos_solve(hamiltonian, psi0, results.data.t.', ...
            output_funhandles, obj.time_step_size);

        % Fill the SolverResults with the outputs of the simulation
        for i = 1:length(output_fnames)
            results.data.(output_fnames{i}) = outputs{i};
        end
    else
        % Basis is small; use a straightforward OdeSolver instead
        results = OdeSolver(obj.t_final, obj.t_resolution, ...
            obj.odesolver_tolerance).solve(hamiltonian, psi0, ...
            output_fnames, output_funhandles);
    end
end
