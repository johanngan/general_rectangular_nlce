function rectangles = get_rectangle_list(~, max_order)
    % RECTANGLES = GET_RECTANGLE_LIST(MAX_ORDER)
    %   Returns a list of all rectangles of order <= max_order. The list is
    %   in the form of an (r x 2) matrix, where each row corresponds to a
    %   rectangle and the columns are [base, height].

    rectangles = [];
    for h = 1:2*max_order-1
        rect_h = ((2*max_order-h):-1:1)';
        rectangles = [rectangles; rect_h, repelem(h, length(rect_h))'];
    end
end