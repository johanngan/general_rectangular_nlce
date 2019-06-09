function hamiltonian = make_hamiltonian(obj, rectangle_size, ~)
    % HAMILTONIAN = MAKE_HAMILTONIAN(RECTANGLE_SIZE, SYSTEM_DISPLACEMENT)
    % Makes a Hamiltonian action function for the uniform transverse Ising
    % model on a given rectangle.
    % The output is a function handle that takes in a time value and state
    % vector, and returns a new state vector made by acting the Hamiltonian
    % on the input state vector.
    
    % Pre-compute the neighbors for the rectangle
    lattice = rectangular_lattice(rectangle_size(1), rectangle_size(2));
    nbrs = lattice.Edges.EndNodes;

    hamiltonian = @(t, psi) ...
        -obj.interaction_strength * sum_sigma_zz(psi, nbrs) ...
        -obj.transverse_field * sum_sigma_x(psi);
end