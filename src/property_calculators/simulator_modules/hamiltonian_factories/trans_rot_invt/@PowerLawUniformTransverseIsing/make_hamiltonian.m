function hamiltonian = make_hamiltonian(obj, rectangle_size, ~)
    % HAMILTONIAN = MAKE_HAMILTONIAN(RECTANGLE_SIZE, SYSTEM_DISPLACEMENT)
    % Makes a Hamiltonian action function for the uniform transverse Ising
    % model with power law interactions on a given rectangle.
    % The output is a function handle that takes in a time value and state
    % vector, and returns a new state vector made by acting the Hamiltonian
    % on the input state vector.

    % Pre-compute the pairs and their couplings.
    nsites = prod(rectangle_size);
    interactions = zeros(nsites*(nsites-1)/2, 3);
    pair_idx = 0;
    for i = 1:nsites
        for j = i+1:nsites
            pair_idx = pair_idx + 1;  % Current pair index
            interactions(pair_idx, :) = [i, j, obj.calc_interaction(...
                get_site_distance(rectangle_size, i, j))];
        end
    end
    
    hamiltonian = @(t, psi) ...
        -sum_sigma_zz(psi, interactions) ...
        -obj.transverse_field * sum_sigma_x(psi);
end