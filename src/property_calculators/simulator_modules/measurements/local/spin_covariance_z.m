function covz = spin_covariance_z(psi, rectangle_size, ...
    measurement_displacement, r_sep)
    % Calculates the spin-z covariance of two sites i and j for a state
    % vector psi on a lattice of spin-1/2 particles.
    % measurement_displacement specifies the displacement of site i from
    % site 1 (origin), and r_sep specified the displacement of site j from
    % site i. Returns 0 if either site is off the rectangle.
    covx = spin_covariance(psi, rectangle_size, ...
        measurement_displacement, r_sep, @sigma_zz, @sigma_z);
end
