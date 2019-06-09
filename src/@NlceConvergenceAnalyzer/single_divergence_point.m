function idx_diverge = single_divergence_point(obj, nlce, ref)
    % IDX_DIVERGE = SINGLE_DIVERGENCE_POINT(NLCE, REF)
    %   Find divergence point for a single NLCE compared to a reference
    %   curve. Same as the public divergence_points, but only for one pair
    %   of curves.
    
    % Find where single points diverge from the reference by a relative
    % difference of more than divergence_tolerance
    single_point_divergence = abs(nlce - ref) > obj.divergence_tolerance;
    % Find the first string of divergence_window consecutive single-point
    % divergences, and set the divergence index to be the first in that
    % string.
    idx_diverge = find(...
        movsum(single_point_divergence, [0, obj.divergence_window-1]) ...
            >= obj.divergence_window, 1);
    if isempty(idx_diverge)
        idx_diverge = nan;
    end
end