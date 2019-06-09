function psi = sigma_z(psi, i)
    % Applies sigma_z at site i to state psi
    
    % - The left part fills all combinations of the ith to nth bits.
    % - The right part fills all combinations of the 0th to (i-2)th bits.
    % - Adding a column to a row combines all combinations of each.
    idx = bitshift(0:bitshift(length(psi), -i)-1, i) + (0:2^(i-1)-1)';
    % - Collapse the matrix of combinations into a linear array of indexes.
    % - Offset by 1 since MATLAB uses 1-indexing.
    % - Set the (i-1)th bit to 1, since these are the indexes that will get
    %   a sign flip.
    idx = idx(:) + 1 + 2^(i-1);
    psi(idx) = -psi(idx);
end