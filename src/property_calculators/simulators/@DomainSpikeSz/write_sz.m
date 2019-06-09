function write_sz(obj, rectangle_size, domain_spike_x, sz_map)
    % WRITE_SZ(RECTANGLE_SIZE, DOMAIN_SPIKE_X, SX_MAP)
    %   Writes a map of Sz values to a single file in key:value format.
    fid = fopen(obj.get_storefilename(rectangle_size, domain_spike_x), 'w+');
    keys = sz_map.keys;
    for i = 1:length(keys)
        fprintf(fid, '%s:%s\n', keys{i}, mat2str(sz_map(keys{i})));
    end
    fclose(fid);
end