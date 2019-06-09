function prop = read_store(obj, rectangle_size, system_displacement, ...
    measurement_displacement)
    % PROP = READ_STORE(RECTANGLE_SIZE, SYSTEM_DISPLACEMENT,
    %   MEASUREMENT_DISPLACEMENT)
    %   Reads a precomputed property measurement, displaced by some amount,
    %   under the rectangle size and system displacement.
    %   Assuming the computed property exists in storage.

    prop = [];
    key = obj.get_key(measurement_displacement);
    
    fid = fopen(obj.get_storefile(rectangle_size, system_displacement), ...
        'r');
    tline = fgetl(fid);
    while ischar(tline)
        if isempty(tline)
            continue
        end
        
        pair = split(tline, ':');   % Key:val delimited by a colon
        if string(pair{1}) == key
            prop = eval(pair{2});
            break;  % Stop after the needed measurement has been found
        end
        tline = fgetl(fid);
    end
    fclose(fid);
    
    if isempty(prop)
        warning('Value for key: "%s" could not be found!', key);
    end
end