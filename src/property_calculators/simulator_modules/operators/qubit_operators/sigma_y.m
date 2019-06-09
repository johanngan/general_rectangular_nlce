function psi = sigma_y(psi, i)
    % Applies sigma_y at site i to state psi
    %
    % Use the relation that Sy = i*Sx*Sz
    psi = 1i*sigma_x(sigma_z(psi, i), i);
end