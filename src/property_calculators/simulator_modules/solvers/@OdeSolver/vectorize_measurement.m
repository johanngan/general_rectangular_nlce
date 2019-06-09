function vect_measurement_fcn = vectorize_measurement(measurement_fcn)
    % VECT_MEASUREMENT_FCN = VECTORIZE_MEASUREMENT(MEASUREMENT_FCN)
    %   Vectorizes a measurement function
    %   output = measurement_fcn(psi) to take a matrix psi where each
    %   column is a state vector, and output a column vector of
    %   measurements corresponding to each column of the matrix.
    vect_measurement_fcn = @(psi_array) vect_fcn(measurement_fcn, psi_array);
end

function outputs = vect_fcn(measurement_fcn, psi_array)
    % Skeleton for vectorized measurement function
    outputs = zeros(size(psi_array, 2), 1);
    for i = 1:size(psi_array, 2)
        outputs(i) = measurement_fcn(psi_array(:, i));
    end
end