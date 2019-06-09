% Supporting function, not an actual operator
function n = nsites(psi)
    % Recovers the number of sites given a state vector.
    n = log2(length(psi));
end