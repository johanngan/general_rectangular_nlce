function mx = magnetization_x(psi, rectangle_size, measurement_displacement)
    % Calculates the x-magnetization at some displacement from site 1 for a
    % state vector psi on a lattice of spin-1/2 particles.
    mx = local_real_measurement(psi, rectangle_size, ...
        measurement_displacement, @sigma_x);
end
