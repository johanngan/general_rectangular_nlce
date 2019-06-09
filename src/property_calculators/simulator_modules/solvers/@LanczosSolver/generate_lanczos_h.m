function [h, Q] = generate_lanczos_h(obj, H_action, v0)
    % Generates the reduced Hamiltonian matrix in the Lanczos
    % subspace of order obj.basis_size given a time-independent Hamiltonian
    % operator and an initial state (or a lower than order-(obj.basis_size)
    % Lanczos basis matrix). H_action should be a function handle taking in
    % a vector and returning the time-independent action of H on that
    % vector. Output is the reduced Hamiltonian in the Lanczos basis
    % (square with size obj.basis) and the basis vector matrix Q.
    Q = obj.generate_basis(H_action, v0);
    h = zeros(size(Q));
    for i = 1:size(Q, 2)
        h(:, i) = H_action(Q(:, i));
    end
    h = Q'*h;   % This matrix should be tridiagonal!
    % h is also called "T_m" in some sources
    % (See https://na.uni-tuebingen.de/ex/num4_ss10/lecture/chap3.pdf)
end