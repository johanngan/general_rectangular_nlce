function displacement = get_site_displacement(rectangle_size, idx)
    % Calculates the displacement of a site at some index from the site at
    % the origin (site 1) on some rectangle. Returns NaN if the index is
    % out of range.
    if idx < 1 || idx > prod(rectangle_size)
        displacement = nan;
        return;
    end
    displacement = [mod(idx-1, rectangle_size(1)), ...
                    floor((idx-1)/rectangle_size(1))];
end
