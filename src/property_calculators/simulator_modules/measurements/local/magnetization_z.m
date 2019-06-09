function mz = magnetization_z(psi, rectangle_size, measurement_displacement)
    % Calculates the z-magnetization at some displacement from site 1 for a
    % state vector psi on a lattice of spin-1/2 particles.
    mz = local_real_measurement(psi, rectangle_size, ...
        measurement_displacement, @sigma_z);
end
