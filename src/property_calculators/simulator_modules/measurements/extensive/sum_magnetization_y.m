function prop = sum_magnetization_y(psi, ~, ~)
% Calculates the sum of y-magnetizations across all sites for a state
% vector psi on a lattice of spin-1/2 particles.
    % Force to be real, as known for Hermitian operators
    prop = real(dot(psi, sum_sigma_y(psi)));
end
