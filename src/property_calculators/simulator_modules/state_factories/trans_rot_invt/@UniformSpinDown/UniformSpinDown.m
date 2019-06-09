classdef UniformSpinDown < StateFactory
    % UNIFORMSPINDOWN State factory for uniform spin-down spins in the
    % computational (Sz) basis.
    
    methods
        function state_vector = make_state(obj, rectangle_size, ~)
            % STATE_VECTOR = MAKE_STATE(RECTANGLE_SIZE, SYSTEM_DISPLACEMENT)
            %   Makes a uniform spin-down state on the given rectangle
            n = obj.get_nsites(rectangle_size);
            state_vector = [zeros(2^n-1, 1); 1];
        end
    end
end

