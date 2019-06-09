function idx = get_site_idx(rectangle_size, displacement)
    % Calculates the site index corresponding to some displacement for the
    % site at the origin (site 1) on some rectangle. Returns 0 if the
    % displacement gives a site off the rectangle.
    if any(displacement + 1 > rectangle_size) ...
        || any(displacement < 0) % Off the grid
        idx = 0;
        return;
    end
    idx = 1 + dot([1, rectangle_size(1:end-1)], displacement);
end
