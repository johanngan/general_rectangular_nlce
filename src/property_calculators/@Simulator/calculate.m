function property = calculate(obj, rectangle_size)
    % PROPERTY = CALCULATE(RECTANGLE_SIZE)
    %   Calculates some extensive property (sum of translated properties)
    %   for some given rectangle size.
    property = 0;   % Initialize sum
    % Get the symmetric partner of the rectangle, if necessary, to save
    % redundant computation
    rectangle_size = obj.symmetry_transform(rectangle_size);
    [system_displacements, measurement_displacements] = ...
        obj.get_displacements_for_prop_calculation(rectangle_size);
    % Validate that get_displacements_for_prop_calculation() was
    % properly overridden, and that the output displacement arrays have
    % equal lengths. If not, print a warning.
    if length(system_displacements) ~= length(measurement_displacements)
        warning("Cell array outputs from " ...
            + "get_displacements_for_prop_calculation have unequal " ...
            + "lengths:\n" ...
            + "    [output 1] system_displacements: %i\n" ...
            + "    [output 2] measurement_displacements: %i", ...
            length(system_displacements), ...
            length(measurement_displacements));
    end
    
    for i = 1:length(system_displacements)
        if ~isfile(obj.get_storefile(rectangle_size, system_displacements{i}))
            % Simulate + write results to file
            obj.simulate(rectangle_size, system_displacements{i});
        end
        % Read from file and add to the total sum
        property = property + obj.read_store(rectangle_size, ...
            system_displacements{i}, measurement_displacements{i});
    end
end