function v = generate_next_basis_vec(H_action, V, m)
    % Generates the mth basis vector of the Lanczos basis given a matrix V
    % of the first m-1 basis (column) vectors and the time-independent 
    % Hamiltonian operator
    % Output is the mth (column) vector
    % Both m and V must be given because V might be preallocated with
    % placeholder columns for uncomputed basis vectors
    v = H_action(V(:, m-1));
    % Gram-Schmidt orthogonalization against the previous vectors
    % THIS IS EXPERIMENTAL: NEED TO CLEAN UP
    max_overlap = inf;
    tol = 1e-6;
    sweeps = 0;
    while max_overlap > tol
        max_overlap = 0;
        sweeps = sweeps + 1;
        % Orthogonalize
        for i = 1:m-1
            v = v - V(:, i)'*v*V(:, i);
            v = v/norm(v);
        end
        % Double-check orthogonality, since orthogonalizing against more
        % recent vectors may have thrown off orthogonality with earlier
        % vectors
        for i = 1:m-1
            max_overlap = max(max_overlap, abs(V(:, i)'*v));
        end
    end
    if norm(v) < 1e-6
        warning('Lanczos basis vector close to 0');
    end
end

% function v = generate_next_basis_vec(H_action, V, m)
%     v = H_action(V(:, m-1));
%     % Gram-Schmidt orthogonalization against the previous vectors
%     v = v - sum((V(:, 1:m-1)'*v).' .* V(:, 1:m-1), 2);
%     if norm(v) < 1e-6
%         warning('Lanczos basis vector close to 0');
%     end
%     v = v/norm(v);    % Normalization
% end