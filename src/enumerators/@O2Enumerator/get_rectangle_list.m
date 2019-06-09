function rectangles = get_rectangle_list(~, max_order)
    % RECTANGLES = GET_RECTANGLE_LIST(MAX_ORDER)
    %   Returns a list of all rectangles of order <= max_order. The list is
    %   in the form of an (r x 2) matrix, where each row corresponds to a
    %   rectangle and the columns are [base, height].
    
    rectangles = [];
    for i = max_order:-1:1
        rect_i = (1:floor(max_order/i))';
        rectangles = [rectangles; repelem(i, length(rect_i))', rect_i];
    end
end