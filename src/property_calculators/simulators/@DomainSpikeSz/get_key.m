function key = get_key(obj, rectangle_size, domain_spike_x, site_x, site_y)
    % KEY = GET_KEY(RECTANGLE_SIZE, DOMAIN_SPIKE_X, SITE_X, SITE_Y)
    %   Forms the map key for the measurement under the given parameters
    %   [base, height, domain spike x, site x, site y]
    key = mat2str([rectangle_size, domain_spike_x, site_x, site_y]);
end