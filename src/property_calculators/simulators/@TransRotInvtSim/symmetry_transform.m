function rectangle_size = symmetry_transform(~, rectangle_size)
    % RECTANGLE_SIZE = SYMMETRY_TRANSFORM(RECTANGLE_SIZE)
    %   Transforms a rectangle into a rectangle with the dimensions ordered
    %   in ascending order.
    rectangle_size = sort(rectangle_size);
end