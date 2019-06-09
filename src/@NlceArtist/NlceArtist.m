classdef NlceArtist
    %NLCEARTIST Plots NLCE-related things
    
    properties
        color_order
        
        % padding on the ranges to plot
        padding
        
        % Legend entry skeleton
        order_label
    end
    
    methods
        function obj = NlceArtist(color_order, padding, order_label)
            % NLCEARTIST(COLOR_ORDER, PADDING, ORDER_LABEL)
            %   Construct an instance of this class
            %   color_order is a (cx3) array detailing the color order for
            %   plotted lines. If none is specified, defaults to an empty
            %   matrix. If color_order is empty, a set of maximally
            %   distinguishable colors is used for plotting.
            %   padding are the amounts of extension on the x and y plot
            %   limits, normalized to the unpadded x and y plot limits,
            %   in a vector of the format: [top, right, bottom, left]
            %   Defaults to [0.1, 0.1, 0.1, 0]
            %   order_label is a format string specifying how legend
            %   entries should be formatted.

            if nargin < 3
                order_label = 'Order %g';
            end
            if nargin < 2
                padding = [0.1, 0.1, 0.1, 0];
            end
            if nargin < 1
                color_order = [];
            end
            
            obj.color_order = color_order;
            obj.padding = padding;
            obj.order_label = order_label;
        end
        
        plot_orders(obj, xvals, nlces, orders, converged_curve, plotter);
        plot_vline(obj, x, varargin);
    end
end

