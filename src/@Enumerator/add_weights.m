function weights_matrix = add_weights(obj, rectangles)
    % WEIGHTS_MATRIX = ADD_WEIGHTS(RECTANGLES)
    %   Adds together the weights matrices of different rectangles.
    %   rectangles is an (r x 3) matrix where each row is a rectangle and
    %   columns are: [base, height, multiplicity]. Output is a combined
    %   weights matrix where weights of the same rectangle are combined
    %   into a single row.
    %
    %   Weights matrices are read from the weights map property. If a
    %   rectangle is not found in the map, an error is thrown.
    
    weights_matrix = [];

    % Holds the cumulative weight values for the rectangle
    sub_weights_map = containers.Map;
    for i = 1:size(rectangles, 1)
        % Holds the weight values of the current sub-rectangle
        % To be tallied up into the sub_weights_map
        sub_weights = obj.weights_map(obj.rect_to_key(rectangles(i, 1:2)));
        for j = 1:size(sub_weights, 1)
            sub_key = obj.rect_to_key(sub_weights(j, 1:2));
            if(~sub_weights_map.isKey(sub_key))
                sub_weights_map(sub_key) = 0;
            end

            sub_weights_map(sub_key) = ...
                sub_weights_map(sub_key) + rectangles(i, 3)*sub_weights(j, 3);
        end
    end
    
    % Now transfer the accumulated weights for the rectangle
    % into the output matrix
    sub_keys = sub_weights_map.keys;
    for i = 1:length(sub_keys)
        sub_weight = sub_weights_map(sub_keys{i});
        if sub_weight ~= 0
            weights_matrix = [weights_matrix; ...
                obj.key_to_rect(sub_keys{i}), sub_weight];
        end
    end
end