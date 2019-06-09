function hamiltonian = make_hamiltonian(obj, rectangle_size, ~)
    % HAMILTONIAN = MAKE_HAMILTONIAN(RECTANGLE_SIZE, SYSTEM_DISPLACEMENT)
    % Makes a Hamiltonian action function for the power-law Ising model in
    % https://journals.aps.org/prx/abstract/10.1103/PhysRevX.8.021069
    % on a given rectangle.
    % The output is a function handle that takes in a time value and state
    % vector, and returns a new state vector made by acting the Hamiltonian
    % on the input state vector.

    % Pre-compute the pairs and their couplings, along with the base
    % detunings for each site.
    nsites = prod(rectangle_size);
    interactions = zeros(nsites*(nsites-1)/2, 3);
    pairwise_interaction_matrix = zeros(nsites);
    pair_idx = 0;
    for i = 1:nsites
        for j = i+1:nsites
            pair_idx = pair_idx + 1;  % Current pair index
            
            pairwise_interaction_matrix(i, j) = obj.calc_interaction(...
                get_site_distance(rectangle_size, i, j, ...
                    obj.lattice_spacings));
            interactions(pair_idx, :) = [i, j, ...
                pairwise_interaction_matrix(i, j)];
        end
    end
    
    if ~isinf(obj.neighbor_rank_limit)
        % Keep only the strongest interactions, and throw out the rest
        cutoff = maxk(abs(interactions(:, 3)), ...
            obj.neighbor_rank_limit);
        cutoff = cutoff(end);
        interactions = interactions(abs(interactions(:, 3)) >= cutoff, :);
        pairwise_interaction_matrix(abs(pairwise_interaction_matrix) < cutoff) = 0;
    end
    
    pairwise_interaction_matrix = pairwise_interaction_matrix + ...
        pairwise_interaction_matrix';   % Fill in the other half
    % Vector of base detunings
    base_detunings = sum(pairwise_interaction_matrix, 1) / 2;
    
    % Divide sigma_zz by 4 to go from sigma_z to S_z, divide sigma_z(x) to
    % go from sigma_z(x) to S_z(x).
    hamiltonian = @(t, psi) ...
        sum_sigma_zz(psi, interactions) / 4 ...
        + sum_sigma_z(psi, base_detunings - obj.detuning(t)) / 2 ...
        + obj.rabi_frequency(t) * sum_sigma_x(psi) / 2;
end

