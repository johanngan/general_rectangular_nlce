function my = magnetization_y(psi, rectangle_size, measurement_displacement)
    % Calculates the y-magnetization at some displacement from site 1 for a
    % state vector psi on a lattice of spin-1/2 particles.
    my = local_real_measurement(psi, rectangle_size, ...
        measurement_displacement, @sigma_y);
end
