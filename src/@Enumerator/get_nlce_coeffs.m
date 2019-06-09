function nlce_coeffs = get_nlce_coeffs(obj, nlce_order)
    % NLCE_COEFFS = GET_NLCE_COEFFS(NLCE_ORDER)
    %   Calculates the NLCE coefficients matrix of a given order.
    %   The output matrix is an (s x 3) matrix where each row
    %   corresponds to a rectangle of order <= nlce_order, and
    %   and the columns having values [base, height, coefficient].
    %   The NLCE approximation is given by sum(c_r*P_r) where
    %   c_r is the coefficient (3rd column) of rectangle r, and
    %   P_r is some extensive property computed on rectangle r.

    rects = obj.get_rectangle_list(nlce_order);
    rects = [rects, ones(size(rects, 1), 1)];
    
    for r = 1:size(rects, 1)                  
        % Fill the weights map with each rectangle's weights
        obj.calc_weights(rects(r, 1), rects(r, 2));
    end
    
    % Sum all the weights of all the rectangles
    %   *Extra column of ones specifies simple summation (equal
    %   multiplicities)
    nlce_coeffs = obj.add_weights([rects, ones(size(rects, 1), 1)]);
end