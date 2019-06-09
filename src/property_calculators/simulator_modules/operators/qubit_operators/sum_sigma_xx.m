function psi_out = sum_sigma_xx(psi_in, pairs)
    % Applies the weighted sum products of pairs of sigma_x Pauli matrices
    % in a lattice to state psi_in.
    %
    % psi_in and psi_out are assumed vectors with a power-of-two length.
    % pairs is a (px3) matrix where each row corresponds to a pair of
    % site indexes, and a weight for the total sum contribution. If pairs
    % is (px2), the weights are assumed 1.
    psi_out = sum_bilocal(psi_in, pairs, @sigma_xx);
end
