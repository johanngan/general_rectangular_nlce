classdef NlceCalculator
    % NLCECALCULATOR Performs rectangular NLCE series calculations.
    %   Performs rectangular NLCE summation tasks for a general property.
    %   Must be initialized with a PropertyCalculator member to specify
    %   how the property on each subrectangle should be calculated, and an
    %   Enumerator member to specify which series to use.
    
    properties
        property_calculator
        enumerator
        writer
    end
    
    methods
        function obj = NlceCalculator(property_calculator, enumerator, writer)
            % NLCECALCULATOR(PROPERTY_CALCULATOR, ENUMERATOR, WRITEFUN)
            %   Construct an instance of this class.
            %
            %   property_calculator is a PropertyCalculator instance that
            %   will be used to compute the property on each subrectangle
            %   in the NLCE series. enumerator is an Enumerator instance
            %   that specifies which NLCE series to use. writer is an
            %   optional Writer instance that specifies how to write
            %   results to files. Defaults to a base Writer object.
            
            if nargin < 1
                error('Missing PropertyCalculator.');
            end
            if nargin < 2
                error('Missing Enumerator.');
            end
            if nargin < 3
                writer = Writer;
            end
            
            obj.property_calculator = property_calculator;
            obj.enumerator = enumerator;
            obj.writer = writer;
        end
        
        nlce = calc_nlce(obj, nlce_order, outfilename, verbose);
    end
end

