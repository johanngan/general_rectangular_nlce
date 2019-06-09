function psi = sigma_yy(psi, i, j)
% Applies sigma_x to psi over sites i and j
% i, j = indexes
%
% Use the relation that Sy = i*Sx*Sz
%
% Note: for sufficiently large psi, this is faster than applying sigma_y
% twice.
    if i ~= j
        psi = -sigma_xx(sigma_zz(psi, i, j), i, j);
    end
    % Self-connection is a special case and turns into the identity
    % operator
end