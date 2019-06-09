function psi_out = sum_bilocal(psi_in, pairs, operator)
    % Applies the sum of some site-bilocal (involving 2 sites) operator to
    % state psi_in.
    % psi_in and psi_out are assumed vectors with a power-of-two length.
    % pairs is a (px3) matrix where each row corresponds to a pair of
    % site indexes, and a weight for the total sum contribution. If pairs
    % is (px2), the weights are assumed 1.
    % operator is a function handle with inputs (psi_in, idx 1, idx 2)
    if size(pairs, 2) < 3   % Unweighted sum
        psi_out = sum_bilocal_unweighted(psi_in, pairs, operator);
    else % Weighted sum
        psi_out = sum_bilocal_weighted(psi_in, pairs, operator);
    end
end

function psi_out = sum_bilocal_weighted(psi_in, pairs, operator)
    % Applies weighted sum of some site-bilocal operator to state psi_in.
    psi_out = zeros(size(psi_in));
    for i = 1:size(pairs, 1)
        psi_out = psi_out + ...
            pairs(i, 3)*operator(psi_in, pairs(i, 1), pairs(i, 2));
    end
end

function psi_out = sum_bilocal_unweighted(psi_in, pairs, operator)
    % Applies unweighted sum of some site-bilocal operator to state psi_in.
    % Can be done with the weighted version, but this function is just a
    % little cheaper.
    psi_out = zeros(size(psi_in));
    for i = 1:size(pairs, 1)
        psi_out = psi_out + operator(psi_in, pairs(i, 1), pairs(i, 2));
    end
end