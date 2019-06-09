classdef NlceConvergenceAnalyzer
    % NLCECONVERGENCEANALYZER Analyzing the convergence of the NLCE
    % approximation
    
    properties
        % Maximum absolute difference between points before considering
        % them diverged
        divergence_tolerance
        % Number of consecutive points outside of the tolerance before
        % considering the whole curves diverged
        divergence_window
    end
    
    methods
        function obj = NlceConvergenceAnalyzer(divergence_tolerance, ...
                divergence_window)
            % NLCECONVERGENCEANALYZER(DIVERGENCE_TOLERANCE,
            %   DIVERGENCE_WINDOW)
            %   Construct an instance of this class
            %
            % divergence_tolerance is the maximum relative difference
            % between points before considering them diverged.
            %
            % divergence_window is the number of consecutive points outside
            % of the tolerance before considering the whole curves diverged
            % Defaults to 5.
            if nargin < 2
                divergence_window = 5;
            end
            
            obj.divergence_tolerance = divergence_tolerance;
            obj.divergence_window = divergence_window;
        end
        
        nlces = calc_multiple_nlces(obj, nlce_calculator, nlce_orders, ...
            outfilebase, verbose)
        idx_diverge = divergence_points(obj, nlces);
        converged = converged_curve(obj, nlces);
    end
    
    methods(Static)
        tagged = tag_filename(filename, nlce_order);
    end
    
    methods(Access = private)
        idx_diverge = single_divergence_point(obj, nlce, ref);
    end
end

