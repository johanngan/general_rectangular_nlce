function psi = sigma_xx(psi, i, j)
% Applies sigma_x to psi over sites i and j
% i, j = indexes
%
% Note: for sufficiently large psi, this is faster than applying sigma_x
% twice.
    if i ~= j
        psi = psi(1+bitxor(0:length(psi)-1, 2^(i-1) + 2^(j-1)));
    end
    % Self-connection is a special case and turns into the identity
    % operator
end