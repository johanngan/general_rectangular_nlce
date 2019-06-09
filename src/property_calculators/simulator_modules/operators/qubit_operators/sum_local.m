function psi_out = sum_local(psi_in, operator, weights)
    % Applies the sum (weighted or unweighted) of some site-local operator
    % to state psi_in. psi_in and psi_out are assumed vectors with a
    % power-of-two length. operator is a function handle with inputs
    % (psi_in, site idx). weights is a vector containing the weights of
    % each site.
    psi_out = zeros(size(psi_in));
    
    if nargin < 3   % unweighted - saves a bit of computation
        for i = 1:nsites(psi_in)
            psi_out = psi_out + operator(psi_in, i);
        end
    else    % weighted
        for i = 1:nsites(psi_in)
            psi_out = psi_out + weights(i)*operator(psi_in, i);
        end
    end
end