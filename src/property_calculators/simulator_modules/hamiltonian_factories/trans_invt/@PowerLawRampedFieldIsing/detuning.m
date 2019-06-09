function delta = detuning(obj, time)
    % DELTA = DETUNING(TIME)
    % Computes the detuning at some time
    % Constant until the Rabi frequency is done ramping, then linearly
    % ramping, then constant again upon reaching its final value.
    if time < obj.rabi_frequency_ramp_time
        delta = obj.detuning_initial;
    elseif time >= obj.rabi_frequency_ramp_time + obj.detuning_ramp_time
        delta = obj.detuning_final;
    else
        delta = obj.detuning_initial + ...
            (obj.detuning_final - obj.detuning_initial) * ...
            (time - obj.rabi_frequency_ramp_time) / obj.detuning_ramp_time;
    end
end