function sum_cov_y = sum_spin_covariance_y(psi, rectangle_size, ...
    measurement_displacement, r_sep)
    % Calculates the sum of spin-y covariances of relative separation r_sep
    % over all pairs of sites for a state vector psi in the given
    % rectangle.
    sum_cov_y = sum_spin_covariance(psi, rectangle_size, ...
        measurement_displacement, r_sep, @sigma_yy, @sigma_y);
end
