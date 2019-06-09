function psi = sigma_xx_plus_yy(psi, i, j)
    % Applies sigma_xi*sigma_xj + sigma_yi*sigma_yj to psi for sites i and j
    % i, j = indexes
    %
    % Use the relation that Sy = i*Sx*Sz
    %
    % Note: for sufficiently large psi, this is faster than applying
    % sigma_xx and sigma_yy separately, since sigma_yy involves applying
    % both sigma_xx and sigma_zz.
    
    if i ~= j
        psi = sigma_xx(psi - sigma_zz(psi, i, j), i, j);
    else
        % Self-connection is a special case and turns into the sum of two
        % identity operators
        psi = 2*psi;
    end
end