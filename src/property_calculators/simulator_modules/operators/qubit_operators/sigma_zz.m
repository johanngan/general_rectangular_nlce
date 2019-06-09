function psi = sigma_zz(psi, i, j)
% Applies sigma_z to psi over sites i and j
% i, j = indexes
%
% Note: for sufficiently large psi, this is faster than applying sigma_z
% twice.

    if i ~= j
        idx = sigma_z_idx_to_negate(i, j, nsites(psi));
        psi(idx) = -psi(idx);
    end
    % Self-connection is a special case and turns into the identity
    % operator. Not strictly necessary to get the right answer, but saves
    % time on useless operation, especially for large state vectors.
end