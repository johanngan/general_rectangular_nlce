classdef(Abstract) PropertyCalculator < handle
    % PROPERTYCALCULATOR Calculates some property on a given rectangle.
    %   Performs simulation/computation for a general property, to be used
    %   by the NlceCalculator to compute the NLCE estimate.
    
    methods(Abstract)
        property = calculate(obj, rectangle_size);
    end
end

