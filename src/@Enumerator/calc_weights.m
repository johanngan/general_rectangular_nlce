function weights_matrix = calc_weights(obj, base, height)
    % WEIGHTS_MATRIX = CALC_WEIGHTS(BASE, HEIGHT)
    %   Calculates the weights matrix for a rectangle with given base and
    %   height and returns it. Also stores it in the weights map if not
    %   already there.
    
    % If the desired weight is already in the map, just return
    if obj.weights_map.isKey(obj.rect_to_key([base, height]))
        weights_matrix = obj.weights_map(obj.rect_to_key([base, height]));
        return
    end

    % Descending order of multiplicity (roughly ascending order of area)
    % The point is: the summation terms for the weight of a subrectangle
    % will only involve rectangles with higher multiplicity; any
    % sub-sub-rectangle is guaranteed to have more multiplicity than the
    % subrectangle
    sub_rects = obj.get_subrectangles(base, height);
    if ~isempty(sub_rects)
        sub_rects = sortrows(sub_rects, -3);
    end

    for i = 1:size(sub_rects, 1)
        key = obj.rect_to_key(sub_rects(i, 1:2));
        
        % Skip this sub-calculation if it's already been provided
        if obj.weights_map.isKey(key)
            continue;
        end
        
        % If not, calculate the weights matrix for the current sub-rectangle
        % The weights matrix for (key) always has the corresponding
        % rectangle with weight 1 (the full rectangle itself always has
        % weight 1)
        obj.weights_map(key) = [sub_rects(i, 1:2), 1];
        
        % Sub-rectangles for the current sub-rectangle
        sub_sub_rects = obj.get_subrectangles(sub_rects(i, 1), sub_rects(i, 2));
        
        % Map to 3-column weight matrices
        % Holds the cumulative weight values for the current sub-rectangle
        sub_weights_map = containers.Map;
        for j = 1:size(sub_sub_rects, 1)
            
            % Holds the weight values of the current sub-sub-rectangle
            % To be tallied up into the sub_weights_map
            sub_weights = obj.weights_map(obj.rect_to_key(sub_sub_rects(j, 1:2)));
            for k = 1:size(sub_weights, 1)
                sub_key = obj.rect_to_key(sub_weights(k, 1:2));
                if(~sub_weights_map.isKey(sub_key))
                    sub_weights_map(sub_key) = 0;
                end
                
                sub_weights_map(sub_key) = ...
                    sub_weights_map(sub_key) - ...
                    sub_sub_rects(j, 3)*sub_weights(k, 3);
            end
        end
        
        % Now transfer the accumulated weights for the sub-rectangle
        % into the matrix, stored in the total weights map
        sub_keys = sub_weights_map.keys;
        for j = 1:length(sub_keys)
            sub_weight = sub_weights_map(sub_keys{j});
            if sub_weight ~= 0
                obj.weights_map(key) = [obj.weights_map(key); ...
                    obj.key_to_rect(sub_keys{j}), sub_weight];
            end
        end
    end
    
    weights_matrix = [base, height, 1];
    % Subtract the weights instead of adding
    if ~isempty(sub_rects)
        sub_rects(:, 3) = -sub_rects(:, 3);
    end
    weights_matrix = [weights_matrix; obj.add_weights(sub_rects)];
    
    % Add the final weight to the weights map
    obj.weights_map(obj.rect_to_key([base, height])) = weights_matrix;
    % Save the new weights map to file
    obj.write_weights_map();
end