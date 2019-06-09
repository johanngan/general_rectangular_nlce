function write_weights_map(obj)
    % WRITE_WEIGHTS_MAP()
    %   Updates the weights map file with the newest version.
    
    % Get the old version for comparison
    old_weights_map = obj.read_weights_map(false);
    % Add only the new entries
    new_keys = setdiff(obj.weights_map.keys, old_weights_map.keys);

    % Create the containing folder if it doesn't exist
    [path, ~, ~] = fileparts(obj.map_filename);
    if string(path) ~= "" && ~exist(path, 'dir')
        mkdir(path);
    end
    
    % Create/add to the weights map file
    fid = fopen(obj.map_filename, 'a+');
    for i = 1:length(new_keys)
        fprintf(fid, '%s:%s\n', ...
            new_keys{i}, mat2str(obj.weights_map(new_keys{i})));
    end
    fclose(fid);
end