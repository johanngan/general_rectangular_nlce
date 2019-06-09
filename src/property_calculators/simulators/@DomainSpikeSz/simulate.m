function simulate(obj, rectangle_size, domain_spike_x)
    % SIMULATE(RECTANGLE_SIZE, DOMAIN_SPIKE_X)
    %   Simulates the given rectangle size with the domain spike at a given
    %   position, then calculates and writes to file the x-magnetizations
    %   at each unique site (up to reflection symmetry).
    
    addpath('..');
    
    % Flipped b/c weights uses bxh, while the rectangle ctor uses ixj (hxb)
    rect = rectangular_lattice(rectangle_size(2), rectangle_size(1));
    edges = rect.Edges.EndNodes;

    psi0 = obj.domain_spike_state(rectangle_size, domain_spike_x);
    
    dt = @(t, y) -1i*obj.hamiltonian(edges, y); % Derivative function
    
    nkeys = rectangle_size(1)*ceil(rectangle_size(2)/2);
    keys = cell(1,nkeys);
    fieldnames = cell(size(keys));
    funhandles = cell(size(keys));
    key_idx = 0;
    for site_x = 1:rectangle_size(1)
        % Only record lower half; top half is same by symmetry
        for site_y = 1:ceil(rectangle_size(2)/2)
            key_idx = key_idx + 1;
            
            keys{key_idx} = obj.get_key(...
                rectangle_size, domain_spike_x, site_x, site_y);
            fieldnames{key_idx} = sprintf('sz%i_%i', site_x, site_y);
            
            i = rectangle_size(2) - site_y + 1;
            site_idx = 1 + (i-1)*rectangle_size(1) + (site_x-1);
            funhandles{key_idx} = ...
                @(psi_array) magnetization_z(psi_array, site_idx);
        end
    end
    
    output_fcn = create_scalar_output_fcn(fieldnames, funhandles);
    results = run_sim(dt, obj.t_final, obj.t_res, psi0, obj.tol, output_fcn);
    
    % Copy results into a map
    sz_map = containers.Map;
    for i = 1:length(keys)
        sz_map(keys{i}) = results.data.(fieldnames{i}).'; % Save as a row vector
    end
    % Write results to file
    obj.write_sz(rectangle_size, domain_spike_x, sz_map);
end