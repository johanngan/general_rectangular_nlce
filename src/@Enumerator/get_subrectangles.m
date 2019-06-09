function subrectangles = get_subrectangles(obj, base, height)
    % SUBRECTANGLES = GET_SUBRECTANGLES(BASE, HEIGHT)
    %   Gets all the proper subrectangles of a given rectangle and their
    %   multiplicities. subrectangles is an (s x 3) matrix where each row
    %   is a rectangle, with columns in the format:
    %       [base, height, multiplicity]
    
    subrectangles = [];
    for x = base:-1:1
        for y = height:-1:1
            if x == base && y == height
                continue;
            end
            
            subrectangles = [subrectangles; ...
                x, y, calc_multiplicity(x, y, base, height)];
        end
    end
end

function m = calc_multiplicity(x, y, base, height)
% Multiplicity of an x-by-y subrectangle in an base-by-height rectangle
    m = (base-x+1) * (height-y+1);
end