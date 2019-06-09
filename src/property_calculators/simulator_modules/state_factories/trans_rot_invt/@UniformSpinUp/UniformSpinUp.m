classdef UniformSpinUp < StateFactory
    % UNIFORMSPINUP State factory for uniform spin-up spins in the
    % computational (Sz) basis.
    
    methods
        function state_vector = make_state(obj, rectangle_size, ~)
            % STATE_VECTOR = MAKE_STATE(RECTANGLE_SIZE, SYSTEM_DISPLACEMENT)
            %   Makes a uniform spin-up state on the given rectangle
            n = obj.get_nsites(rectangle_size);
            state_vector = [1; zeros(2^n-1, 1)];
        end
    end
end

