function prop = sum_magnetization_x(psi, ~, ~)
% Calculates the sum of x-magnetizations across all sites for a state
% vector psi on a lattice of spin-1/2 particles.
    % Force to be real, as known for Hermitian operators
    prop = real(dot(psi, sum_sigma_x(psi)));
end
