function pdist_matrix = get_site_pdist(rectangle_size, lattice_spacings)
    % Calculates the pairwise Euclidean distance matrix between sites in a
    % rectangle with certain lattice spacings in each dimension.
    % lattice_spacings is a vector matching rectangle_size with the lattice
    % spacing between adjacent sites in each dimension. Defaults to the
    % ones vector.
    if nargin < 4
        lattice_spacings = ones(size(rectangle_size));
    end
    
    nsites = prod(rectangle_size);
    pdist_matrix = zeros(nsites);
    for i = 1:nsites
        for j = i+1:nsites
            pdist_matrix(i, j) = get_site_distance(rectangle_size, ...
                i, j, lattice_spacings);
        end
    end
    % Fill in the other half by symmetry
    pdist_matrix = pdist_matrix + pdist_matrix';
end
