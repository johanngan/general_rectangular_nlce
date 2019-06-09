function sum_cov = sum_spin_covariance(psi, rectangle_size, ~, r_sep, ...
    sigma2_op, sigma_op)
    % Calculates the sum of spin covariances of relative separation r_sep
    % over all pairs of sites for a state vector psi in the given
    % rectangle.
    % sigma2_op is the function for the product of two spin operators at
    % two sites. sigma_op is the function for the spin operator at one
    % site.

    sum_cov = 0;
    % Cache for single-site magnetizations
    magnetizations_cache = containers.Map(...
        'KeyType', 'uint32', 'ValueType', 'any');
    for dy = 0:rectangle_size(2)-1
        for dx = 0:rectangle_size(1)-1
            measurement_displacement = [dx, dy];
            i = get_site_idx(rectangle_size, measurement_displacement);
            j = get_site_idx(rectangle_size, measurement_displacement + r_sep);
            sum_cov = sum_cov + spin_covariance_with_cache(psi, i, j, ...
                magnetizations_cache, sigma2_op, sigma_op);
        end
    end
    % Force to be real
    sum_cov = real(sum_cov);
end

function [spin_cov, magnetizations_cache] = spin_covariance_with_cache(...
    psi, i, j, magnetizations_cache, sigma2_op, sigma_op)
    % Calculates the spin covariance of two sites i and j for a state
    % vector psi on a lattice of spin-1/2 particles. Returns 0 if either
    % site index is 0. Takes a map of cached single-site magnetizations
    % to prevent redundant computation.
    
    if ~i || ~j
        spin_cov = 0;
    else
         % Calculate for sites i and j if uncalculated
        for site = [i, j]
            if ~magnetizations_cache.isKey(site)
                magnetizations_cache(site) = dot(psi, sigma_op(psi, site));
            end
        end
        % Calculate the covariance using cached single-site magnetizations.
        spin_cov = dot(psi, sigma2_op(psi, i, j)) ...
            - magnetizations_cache(i)*magnetizations_cache(j);
    end
end
