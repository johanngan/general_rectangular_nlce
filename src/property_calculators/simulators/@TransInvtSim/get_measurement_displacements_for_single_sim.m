function measurement_displacements = ...
    get_measurement_displacements_for_single_sim(~, ~, ~)
    % MEASUREMENT_DISPLACEMENTS = 
    %   GET_MEASUREMENT_DISPLACEMENTS_FOR_SINGLE_SIM(
    %       RECTANGLE_SIZE, SYSTEM_DISPLACEMENT)
    % Get the displacements (as a cell array of displacement vectors)
    % that correspond to distinct measurements that can be made by this
    % Simulator under simulation of a given rectangle size and system
    % displacement.
    
    % For a translationally invariant system and extensive property, only
    % one undisplaced measurement is necessary.
    measurement_displacements = {[0, 0]};
end

