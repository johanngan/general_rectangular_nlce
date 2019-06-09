function [outputs, step_boundary_times] = lanczos_solve(obj, ...
    hamiltonian, psi0, tvals, output_funhandles, dt)
    % Lanczos solver. Give a Hamiltonian action function that can be
    % explicitly time-dependent, an initial column state, vector of time
    % values (in ascending order), a cell array of output functions that
    % generates the desired observables from a state, and the order for
    % each Lanczos step, and the maximum size of one Lanczos time step
    % (defaults to doing one large time step).
    %
    % Tries to start steps at given tvals, but will interpolate between
    % gaps that are too large.
    %
    % Output will be a cell array of column vectors of observable values at
    % the given time values relative to the initial state t=0. Also outputs
    % a vector with the boundary time values of the Lanczos steps, and the
    % estimated truncation error of each time step relative to the
    % expansion point (the "t=0" for the step).
    if nargin < 6
        dt = tvals(end);
    end

    % Initialize
    outputs = cell(1, length(output_funhandles));
    for i = 1:length(outputs)
        outputs{i} = zeros(length(tvals), 1);
    end
    
    % Calculate values with successive Lanczos steps with maximum size dt
    step_boundary_times = 0;
    current_time = 0;
    current_psi = psi0;
    i = 1;
    while i <= length(tvals)
        % If the next time value is too far away, interpolate to it before
        % proceeding
        if tvals(i) - current_time > dt
            % Interpolate to the next time using evenly sized steps
            n_dummy_steps = ceil((tvals(i) - current_time) / dt);
            dummy_step_size = (tvals(i) - current_time) / n_dummy_steps;
            
            for dummy_idx = 1:n_dummy_steps
                % Use dummy output function; only interested in state vector
                [~, current_psi] = obj.lanczos_step(...
                    @(y) hamiltonian(current_time, y), current_psi, ...
                    dummy_step_size, @(psi) 0);
            end
            current_time = tvals(i);
            step_boundary_times = [step_boundary_times, ...
                current_time + (1:n_dummy_steps)*dummy_step_size];
        end
        
        % Calculate the next few time values within dt of the current time
        next_idxs = [];
        while i <= length(tvals) && tvals(i) - current_time <= dt
            next_idxs = [next_idxs, i];
            i = i + 1;
        end
        [next_outputs, current_psi] = obj.lanczos_step(...
            @(y) hamiltonian(current_time, y), current_psi, ...
            tvals(next_idxs) - current_time, output_funhandles);
        for j = 1:length(outputs)
            outputs{j}(next_idxs) = next_outputs{j};
        end
        current_time = tvals(next_idxs(end));
        step_boundary_times = [step_boundary_times, current_time];
    end
end