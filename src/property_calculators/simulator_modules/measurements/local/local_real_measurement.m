function prop = local_real_measurement(psi, rectangle_size, ...
    measurement_displacement, operator)
    % Calculates some site-local real measurement at some displacement from
    % site 1 for a state vector psi on a lattice of spin-1/2 particles.
    % operator is a function handle that takes in a state vector and a site
    % index and outputs the operated state vector.
    % Force to be real
    prop = real(dot(psi, operator(psi, ...
        get_site_idx(rectangle_size, measurement_displacement))));
end
