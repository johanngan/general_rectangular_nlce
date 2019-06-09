function V = generate_basis(obj, H_action, v0)
    % Generates a Lanczos basis of order obj.basis_size given a Hamiltonian
    % operator and an initial (normalized) state. H_action should be a
    % function handle taking in a vector and returning the time-independent
    % action of H on that vector.
    %
    % v0 can also be a matrix of Lanczos basis vectors to order less than
    % the basis size. This will save computation time.
    %
    % Output is an Nx(obj.basis_size) matrix corresponding to the basis
    % vectors.
    V = zeros(length(v0), obj.basis_size);
    V(:, size(v0, 2)) = v0;
    for i = 1+size(v0, 2):obj.basis_size
        V(:, i) = obj.generate_next_basis_vec(H_action, V, i);
    end
end