function sum_sz = calculate(obj, rectangle_size)
    % SUM_SZ = CALCULATE(RECTANGLE_SIZE)
    %   Calculates the sum of x-magnetizations at each site in a rectangle
    %   for when the domain spike is a fixed displacement from that site.
    base = rectangle_size(1);
    height = rectangle_size(2);
    
    sum_sz = 0;
    for site_x = 1:base
        for site_y = 1:height
            site_x_eff = site_x;
            site_y_eff = site_y;
            domain_spike_x = obj.calc_domain_spike_x(site_x);
            % Use reflection symmetry to keep the domain spike on the left
            % half of the rectangle
            if domain_spike_x > ceil(base/2)
                domain_spike_x = obj.reflect_idx(domain_spike_x, base);
                site_x_eff = obj.reflect_idx(site_x, base);
            end
            % Do the same with the y measurement position
            if site_y > ceil(height/2)
                site_y_eff = obj.reflect_idx(site_y, height);
            end

            if ~isfile(obj.get_storefilename(rectangle_size, domain_spike_x))
                % Simulate + write results to file
                obj.simulate(rectangle_size, domain_spike_x);
            end
            % Read from file
            sum_sz = sum_sz + obj.read_sz(...
                rectangle_size, domain_spike_x, site_x_eff, site_y_eff);
        end
    end
end