function write_store(obj, rectangle_size, system_displacement, prop_map)
    % WRITE_STORE(RECTANGLE_SIZE, SYSTEM_DISPLACEMENT, PROP_MAP)
    %   Writes a map of property values computed for some rectangle under
    %   some system displacement to a single file in key:value format.
    %
    
    % Create the store directory if it doesn't exist already
    if ~exist(obj.storepath, 'dir')
        mkdir(obj.storepath);
    end
    
    fid = fopen(obj.get_storefile(rectangle_size, system_displacement), ...
        'w+');
    keys = prop_map.keys;
    for i = 1:length(keys)
        fprintf(fid, '%s:%s\n', keys{i}, mat2str(prop_map(keys{i})));
    end
    fclose(fid);
end