function converged = converged_curve(obj, nlces)
    % CONVERGED = CONVERGED_CURVE(NLCES)
    %   Extracts the slice of the highest-order NLCE result that has
    %   converged relative to other results. nlces is a matrix where each
    %   NLCE curve has its own column, with the highest order NLCE in the
    %   last column. For the best results, the NLCE order just below the
    %   highest order should be included.
    idx_diverge = obj.divergence_points(nlces);
    if any(isnan(idx_diverge))
        % Totally converged
        converged = nlces(:, end);
    else
        % Converged on some interval
        converged = nlces(1:max(idx_diverge)-1, end);
    end
end