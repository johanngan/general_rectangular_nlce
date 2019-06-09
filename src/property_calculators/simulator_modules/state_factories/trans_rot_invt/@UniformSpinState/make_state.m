function state_vector = make_state(obj, rectangle_size, ...
        system_displacement)
    % STATE_VECTOR = MAKE_STATE(RECTANGLE_SIZE, SYSTEM_DISPLACEMENT)
    %   Makes a uniform product state with some polar angle for the
    %   given rectangle

    % Save computation time if the state is just a simple spin-up, -right,
    % or -down state.
    if obj.phi == 0
        switch obj.theta
            case 0
                state_vector = UniformSpinUp().make_state(...
                    rectangle_size, system_displacement);
                return;
            case pi/2
                state_vector = UniformSpinRight().make_state(...
                    rectangle_size, system_displacement);
                return;
            case pi
                state_vector = UniformSpinDown().make_state(...
                    rectangle_size, system_displacement);
                return;
        end
    end

    n = obj.get_nsites(rectangle_size);
    sin_powers = sum(dec2bin(0:2^n-1) - '0', 2);
    state_vector = (exp(-1i*obj.phi/2)*cos(obj.theta/2)).^(n - sin_powers) ...
        .* (exp(1i*obj.phi/2)*sin(obj.theta/2)).^sin_powers;
end