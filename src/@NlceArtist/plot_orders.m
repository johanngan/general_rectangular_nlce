function plot_orders(obj, xvals, nlces, orders, converged_curve, plotter)
    % PLOT_ORDERS(XVALS, NLCES, ORDERS, CONVERGED_CURVE, PLOTTER)
    %   Simulatenously plot successive NLCE orders
    %   xvals are the values on the x axis. nlces is a matrix where each
    %   column is the NLCE curve of one order. The best order should be the
    %   last column. orders is a vector of NLCE orders corresponding to
    %   columns in nlces. converged_curve is the converged portion of the
    %   best NLCE curve (inferred somehow). plotter is an optional
    %   parameter specifying the function handle used for plotting lines.
    %   Defaults to @plot.
    
    if nargin < 6
        plotter = @plot;
    end
    
    color_order = obj.color_order;
    if isempty(color_order)
        color_order = distinguishable_colors(length(orders));
    end
    
    if ~isempty(orders)
        % Plot all the curves
        if length(orders) > 1
            plotter(xvals, nlces(:, 1), 'color', color_order(1, :));
            hold on;
            for i = 2:length(orders)-1
                plotter(xvals, nlces(:, i), 'color', color_order(...
                    mod(i-1, size(color_order, 1))+1, :));
            end
        end
        % Highlight the last curve
        plotter(xvals, nlces(:, end), 'color', color_order(...
            mod(length(orders)-1, size(color_order, 1))+1, :), ...
            'marker', 'o', 'markersize', 4);
        hold off;
        
        % Determine the display range
        xmin = min(xvals);
        xmax = max(xvals(1:length(converged_curve)));
        xrange = xmax - xmin;
        ymin = min(converged_curve);
        ymax = max(converged_curve);
        yrange = ymax - ymin;
        
        xlim([xmin, xmax] + xrange*[-obj.padding(4), obj.padding(2)]);
        ylim([ymin, ymax] + yrange*[-obj.padding(3), obj.padding(1)]);
        
        % Add a legend
        legend_entries = cell(1, length(orders));
        for i = 1:length(orders)
            legend_entries{i} = sprintf(obj.order_label, orders(i));
        end
        legend(legend_entries, 'location', 'best');
    end
end