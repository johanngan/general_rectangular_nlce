function output_fcn = create_scalar_output_fcn(fnames, calc_scalars, ...
    vectorize)
    % Creates an output_fcn (for the ODE solver)
    %   - calc_scalars is a cell array of function handles that act on the 
    %       ODE solver Y_OUT format and return a column vector of
    %       observable values
    %   - fnames is a cell array of corresponding names for the scalar
    %       values
    %   - vectorize is an array of flags for whether the corresponding
    %       functions in calc_scalars are in need of vectorization.
    %       Defaults to a 'true' array.
    %
    % The returned output_fcn will has inputs (t, y, flag, results).
    %   - t is the current time value
    %   - y is the current solution vector
    %   - flag is a mode flag passed in by the ODE solver
    %   - results is a SolverResults handle passed in to be mutated with
    %       the computation results. The data field will have a field "t"
    %       containing the solver time values (column vector). It will also
    %       contain fields corresponding to the strings in "fnames", with
    %       values corresponding to the output of each function handle in
    %       "calc_scalars"
    
    % Vectorize all functions by default
    if nargin < 3
        vectorize = repelem(true, length(calc_scalars));
    end
    
    % Array of fully vectorized measurement functions
    calc_scalars_vect = cell(size(calc_scalars));
    for i = 1:length(calc_scalars)
        if vectorize(i)
            calc_scalars_vect{i} = OdeSolver.vectorize_measurement(...
                calc_scalars{i});
        else
            calc_scalars_vect{i} = calc_scalars{i};
        end
    end
    
    output_fcn = @(t, y, flag, results) ...
        output_scalars(t, y, flag, results, fnames, calc_scalars_vect);
end

function status = output_scalars(t, y, flag, results, fnames, calc_scalars)
    % Output function for each ODE solver time step.
    %   - t is the current time value
    %   - y is the current solution vector
    %   - flag is a mode flag passed in by the ODE solver
    %   - results is a SolverResults handle passed in to be mutated with
    %       the computation results
    %   - fieldnames is a cell array containing field names to be populated
    %       in the SolverResults.data structure
    %   - calc_scalars is a cell array of function handles that compute
    %       some measurement given the state vector (as a column vector)
    %
    %   - status is a status code for the ODE solver, and is simply set to
    %       0 for continuation of time-stepping.
    if strcmp(flag, 'init')
        results.data.t = 0;    % Time vector
        for i = 1:length(fnames)
            results.data.(fnames{i}) = calc_scalars{i}(y);
        end
    end
    
    if isempty(flag)
        results.data.t = [results.data.t, t];
        for i = 1:length(fnames)
            results.data.(fnames{i}) = ...
                [results.data.(fnames{i}); calc_scalars{i}(y)];
        end
    end
    
    if strcmp(flag, 'done')
        results.data.t = results.data.t.';
    end
    
    status = 0;
end