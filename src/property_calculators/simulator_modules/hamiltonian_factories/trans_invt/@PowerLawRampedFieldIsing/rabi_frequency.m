function omega = rabi_frequency(obj, time)
    % OMEGA = RABI_FREQUENCY(TIME)
    % Computes the Rabi frequency at some time
    % Ramps to final value, then stays constant, then ramps back to the
    % initial value once the detuning is done ramping.
    if time <= 0 || ...
       time >= 2*obj.rabi_frequency_ramp_time + obj.detuning_ramp_time
        omega = obj.rabi_frequency_initial;
    elseif time >= obj.rabi_frequency_ramp_time && ...
           time <= obj.rabi_frequency_ramp_time + obj.detuning_ramp_time
        omega = obj.rabi_frequency_final;
    elseif time < obj.rabi_frequency_ramp_time
        omega = obj.rabi_frequency_initial + ...
            (obj.rabi_frequency_final - obj.rabi_frequency_initial) * ...
            time / obj.rabi_frequency_ramp_time;
    else
        omega = obj.rabi_frequency_final + ...
            (obj.rabi_frequency_initial - obj.rabi_frequency_final) * ...
            (time - obj.rabi_frequency_ramp_time - obj.detuning_ramp_time) / ...
            obj.rabi_frequency_ramp_time;
    end
    
end