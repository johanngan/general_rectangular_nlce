function sum_cov_x = sum_spin_covariance_x(psi, rectangle_size, ...
    measurement_displacement, r_sep)
    % Calculates the sum of spin-x covariances of relative separation r_sep
    % over all pairs of sites for a state vector psi in the given
    % rectangle.
    sum_cov_x = sum_spin_covariance(psi, rectangle_size, ...
        measurement_displacement, r_sep, @sigma_xx, @sigma_x);
end
