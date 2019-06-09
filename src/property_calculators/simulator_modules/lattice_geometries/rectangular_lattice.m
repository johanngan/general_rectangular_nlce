function lattice = rectangular_lattice(base, height)
% Gives the graph for an (base x height) rectangular lattice
% (N/S/E/W neighbors), enumerated lexicographically from
% left-to-right, bottom-to-top.

    if base == 1 && height == 1
        % Special case: add single node and no edges
        lattice = graph(0);
        return;
    end
    % Horizontal connections
    edges = [setdiff(1:height*base, base:base:height*base)', ...
        base*repelem(0:height-1, base-1)' + repmat((2:base)', height, 1)];
    
    % Vertical connections
    edges = [edges; (1:(height-1)*base)', base + (1:(height-1)*base)'];
    
    lattice = graph(edges(:, 1), edges(:, 2));
end
