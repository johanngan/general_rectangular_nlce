function distance_ij = get_site_distance(rectangle_size, i, j, ...
    lattice_spacings)
    % Calculates the Euclidean distance between sites i and j on some
    % rectangle with certain lattice spacings in each dimension.
    % lattice_spacings is a vector matching rectangle_size with the lattice
    % spacing between adjacent sites in each dimension. Defaults to the
    % ones vector.
    if nargin < 4
        lattice_spacings = ones(size(rectangle_size));
    end
    
    displacement = get_site_displacement(rectangle_size, j) ...
                   - get_site_displacement(rectangle_size, i);
    distance_ij = sqrt(sum((displacement .* lattice_spacings).^2));
end
