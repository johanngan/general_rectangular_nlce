classdef(Abstract) StateFactory < handle
    % STATEFACTORY Creates state vectors
    
    methods(Abstract)
        % Makes a state vector on a given rectangle size, displaced in
        % space by a certain amount.
        state_vector = make_state(obj, rectangle_size, system_displacement);
    end
    
    methods(Static)
        function nsites = get_nsites(rectangle_size)
            % NSITES = GET_NSITES(RECTANGLE_SIZE)
            % Get the number of sites in a rectangle
            nsites = prod(rectangle_size);
        end
    end
end
