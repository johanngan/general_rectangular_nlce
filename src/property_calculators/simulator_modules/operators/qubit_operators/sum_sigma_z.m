function psi_out = sum_sigma_z(psi_in, weights)
    % Applies the sum (weighted or unweighted) of the sigma_z Pauli
    % matrices to state psi_in. psi_in and psi_out are assumed vectors with
    % a power-of-two length. weights is a vector containing the weights of
    % each site.
    if nargin < 2   % unweighted - saves a bit of computation
        psi_out = sum_local(psi_in, @sigma_z);
    else    % weighted
        psi_out = sum_local(psi_in, @sigma_z, weights);
    end
end