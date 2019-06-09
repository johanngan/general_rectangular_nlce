function idx_diverge = divergence_points(obj, nlces)
    % IDX_DIVERGE = DIVERGENCE_POINTS(NLCES)
    %   Finds the latest point of divergence for each successive NLCE curve
    %   in nlces, compared to the highest order result. nlces is a matrix
    %   where each NLCE result has its own column, with the highest order
    %   NLCE in the last column.
    %
    %   Divergence is determined according to the divergence_tolerance and
    %   divergence_window properties. The first subsequence that satisfies
    %   the divergence criterion is the divergence point between two NLCEs.
    %
    %   idx_diverge is a row vector with one less than the total number of
    %   NLCEs, containing the divergence point (index) at which each of the
    %   lower order NLCEs diverges from the highest order one. If
    %   divergence never happened, the index is reported as NaN.
    
    idx_diverge = zeros(1, size(nlces, 2)-1);
    for i = 1:length(idx_diverge)
        idx_diverge(i) = obj.single_divergence_point(...
            nlces(:, i), nlces(:, end));
    end
end
