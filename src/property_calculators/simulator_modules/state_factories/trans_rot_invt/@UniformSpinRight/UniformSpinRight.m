classdef UniformSpinRight < StateFactory
    % UNIFORMSPINRIGHT State factory for uniform spin-right spins in the
    % computational (Sz) basis.
    
    methods
        function state_vector = make_state(obj, rectangle_size, ~)
            % STATE_VECTOR = MAKE_STATE(RECTANGLE_SIZE, SYSTEM_DISPLACEMENT)
            %   Makes a uniform spin-right state on the given rectangle
            n = obj.get_nsites(rectangle_size);
            state_vector = ones(2^n, 1) / sqrt(2^n);
        end
    end
end

