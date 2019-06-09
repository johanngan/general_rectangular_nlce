function domain_spike_x = calc_domain_spike_x(obj, site_x)
    % DOMAIN_SPIKE_X = CALC_DOMAIN_SPIKE_X(SITE_X)
    %   Calculates the position of the domain spike given the position of
    %   the observed site and the configured site distance. Cap the domain
    %   spike position at 0, which is off the rectangle anyway.
    domain_spike_x = max(0, site_x - obj.site_distance);
end

