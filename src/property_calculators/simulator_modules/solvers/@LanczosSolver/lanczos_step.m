function [outputs, psi] = lanczos_step(obj, H_action, psi0, tvals, ...
    output_funhandles)
    % Lanczos time stepper. Give a time-independent Hamiltonian action
    % function, an initial column state, vector of time values, an output
    % function that generates the desired observables from a state, and
    % the order for the Lanczos solver.
    % Output will be a cell array of column vectors of observable values at
    % the given time values relative to the initial state t=0. Each output
    % function is assumed to output a scalar value for a given state
    % vector.
    % Also outputs the state vector at the last given time value, for use
    % in chaining Lanczos steps.
    %
    % Also outputs a truncation error estimate for the largest time step
    % relative to t=0
    outputs = cell(1, length(output_funhandles));
    for i = 1:length(outputs)
        outputs{i} = zeros(length(tvals), 1);
    end
    
    [h, Q] = obj.generate_lanczos_h(H_action, psi0); % Expand around the initial state
    [V, e_vals] = eig(h, 'vector');
    clear h;
    
    O = Q*V;
    clear Q;
    clear V;
    phi0 = O'*psi0; % Effective initial condition in Lanczos basis
    for t = 1:length(tvals)
        psi = O * (exp(-1i*tvals(t)*e_vals) .* phi0);
        outputs{i}(t) = output_funhandles{i}(psi);
    end
end