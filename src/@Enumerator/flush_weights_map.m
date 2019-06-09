function flush_weights_map(obj)
    % FLUSH_WEIGHTS_MAP()
    %   Clears the weights map property (the file remains untouched).
    obj.weights_map = containers.Map;
end