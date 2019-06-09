function interaction = calc_interaction(obj, distance)
    % INTERACTION = CALC_INTERACTION(DISTANCE)
    % Computes the interaction coefficient of two spins given their
    % separation distance.
    interaction = obj.interaction_coefficient ...
                  / distance^obj.interaction_power;
end