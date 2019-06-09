function sz = read_sz(obj, rectangle_size, domain_spike_x, site_x, site_y)
    % SZ = READ_SZ(RECTANGLE_SIZE, DOMAIN_SPIKE_X, SITE_X, SITE_Y)
    %   Reads a precomputed Sz under the given conditions from file,
    %   assuming it exists.

    sz = [];
    key = obj.get_key(rectangle_size, domain_spike_x, site_x, site_y);
    
    fid = fopen(obj.get_storefilename(rectangle_size, domain_spike_x), 'r');
    tline = fgetl(fid);
    while ischar(tline)
        if isempty(tline)
            continue
        end
        
        pair = split(tline, ':');   % Key:val delimited by a colon
        if string(pair{1}) == key
            sz = eval(pair{2});
            break;  % Stop after the needed measurement has been found
        end
        tline = fgetl(fid);
    end
    fclose(fid);
    
    if isempty(sz)
        warning('Sx for key: "%s" could not be found!', key);
    end
end