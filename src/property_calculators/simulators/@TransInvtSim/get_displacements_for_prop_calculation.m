function [system_displacements, measurement_displacements] = ...
    get_displacements_for_prop_calculation(~, ~)
    % [SYSTEM_DISPLACEMENTS, MEASUREMENT_DISPLACEMENTS] = 
    %   GET_DISPLACEMENTS_FOR_PROP_CALCULATION(RECTANGLE_SIZE)
    % Get the system and measurement displacements (as equal-length
    % cell arrays of displacement vectors) over which property
    % calculation must be summed for the total calculation on a given
    % rectangle.
    
    % For a translationally invariant system and extensive property, only
    % one undisplaced measurement is necessary.
    system_displacements = {[0, 0]};
    measurement_displacements = {[0, 0]};
end