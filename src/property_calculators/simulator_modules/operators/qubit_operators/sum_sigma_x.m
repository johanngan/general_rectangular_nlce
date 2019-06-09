function psi_out = sum_sigma_x(psi_in, weights)
    % Applies the sum (weighted or unweighted) of the sigma_x Pauli
    % matrices to state psi_in. psi_in and psi_out are assumed vectors with
    % a power-of-two length. weights is a vector containing the weights of
    % each site.
    if nargin < 2   % unweighted - saves a bit of computation
        psi_out = sum_local(psi_in, @sigma_x);
    else    % weighted
        psi_out = sum_local(psi_in, @sigma_x, weights);
    end
end