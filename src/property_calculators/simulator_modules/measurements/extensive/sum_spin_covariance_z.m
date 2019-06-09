function sum_cov_z = sum_spin_covariance_z(psi, rectangle_size, ...
    measurement_displacement, r_sep)
    % Calculates the sum of spin-z covariances of relative separation r_sep
    % over all pairs of sites for a state vector psi in the given
    % rectangle.
    sum_cov_z = sum_spin_covariance(psi, rectangle_size, ...
        measurement_displacement, r_sep, @sigma_zz, @sigma_z);
end
