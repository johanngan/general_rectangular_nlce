function spin_cov = spin_covariance(psi, rectangle_size, ...
    measurement_displacement, r_sep, sigma2_op, sigma_op)
    % Calculates the spin covariance of two sites i and j for a state
    % vector psi on a lattice of spin-1/2 particles.
    % measurement_displacement specifies the displacement of site i from
    % site 1 (origin), and r_sep specified the displacement of site j from
    % site i. Returns 0 if either site is off the rectangle.
    % sigma2_op is the function for the product of two spin operators at
    % two sites. sigma_op is the function for the spin operator at one
    % site.
    i = get_site_idx(rectangle_size, measurement_displacement);
    j = get_site_idx(rectangle_size, measurement_displacement + r_sep);
    
    if ~i || ~j
        spin_cov = 0;
    else
        spin_cov = dot(psi, sigma2_op(psi, i, j)) ...
            - dot(psi, sigma_op(psi, i))*dot(psi, sigma_op(psi, j));
    end
    % Force to be real
    spin_cov = real(spin_cov);
end
