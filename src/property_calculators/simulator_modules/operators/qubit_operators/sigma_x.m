function psi = sigma_x(psi, i)
    % Applies sigma_x at site i to state psi

    % - Shuffle the indexes by flipping the (i-1)th bit in each.
    % - Offset by 1 because MATLAB uses 1-indexing
    psi = psi(1+bitxor(0:length(psi)-1, 2^(i-1)));
end