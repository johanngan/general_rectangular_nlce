function weights_map = read_weights_map(obj, warn)
    % weights_map = READ_WEIGHTS_MAP(WARN)
    %   Reads the weights map from file. Warn is a flag for whether
    %   warnings should be displayed (default true).
    if nargin < 2
        warn = true;
    end
    
    weights_map = containers.Map;
    
    %   Reads in the weights map from the associated file.
    [fid, errmsg] = fopen(obj.map_filename, 'r');
    if ~isempty(errmsg)
        if warn
            warning('%s\n* %s', errmsg, 'Read empty weights map.');
        end
        return
    end
    
    % Parse file line-by-line
    tline = fgetl(fid);
    while ischar(tline)
        if isempty(tline)
            continue
        end
        
        pair = split(tline, ':');   % Key:val delimited by a colon
        weights_map(pair{1}) = eval(pair{2});
        tline = fgetl(fid);
    end
    fclose(fid);
end