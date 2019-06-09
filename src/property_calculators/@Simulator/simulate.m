function simulate(obj, rectangle_size, system_displacement)
    % SIMULATE(RECTANGLE_SIZE, SYSTEM_DISPLACEMENT,
    %   MEASUREMENT_DISPLACEMENTS)
    %   Simulates the given rectangle size with the Hamiltonian and initial
    %   condition shifted by some amount, then calculates and writes to
    %   file the measurements output by the solver.

    psi0 = obj.initial_state_factory.make_state(...
        rectangle_size, system_displacement);
    hamiltonian = obj.hamiltonian_factory.make_hamiltonian(...
        rectangle_size, system_displacement);
    
    % Get the different displacements for the measurement
    measurement_displacements = ...
        obj.get_measurement_displacements_for_single_sim(...
        rectangle_size, system_displacement);
    
    keys = cell(size(measurement_displacements));
    fnames = cell(size(measurement_displacements));
    funhandles = cell(size(measurement_displacements));
    for i = 1:length(measurement_displacements)
        % Map keys for each displacement, to be cached by the Simulator
        keys{i} = obj.get_key(measurement_displacements{i});
        % Unique identifiers for each displacement, as valid struct field
        % names
        fnames{i} = ['f', sprintf('_%i', measurement_displacements{i})];
        funhandles{i} = @(psi) obj.measurement(...
            psi, rectangle_size, measurement_displacements{i});
    end
    % Run the solver
    results = obj.solver.solve(hamiltonian, psi0, fnames, funhandles);
    
    % Copy results into a map
    prop_map = containers.Map;
    for i = 1:length(keys)
        prop_map(keys{i}) = results.data.(fnames{i});
    end
    % Write results to file
    obj.write_store(rectangle_size, system_displacement, prop_map);
end