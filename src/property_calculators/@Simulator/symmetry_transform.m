function rectangle_size = symmetry_transform(~, rectangle_size)
    % RECTANGLE_SIZE = SYMMETRY_TRANSFORM(RECTANGLE_SIZE)
    %   Transforms some rectangle into a standard equivalent rectangle, if
    %   the system has some symmetry that makes different rectangles
    %   equivalent.
    %   "Standard" means that if, for example, 3x4 = 4x3, then the function
    %   should output just one of them for both inputs. For example,
    %       obj.symmetry_transform([3, 4]) --> [3, 4]
    %       obj.symmetry_transform([4, 3]) --> [3, 4]
    
    % Default behavior: assume no symmetry and do nothing.
    % Override in subclass if extra symmetry optimization is possible
    % E.g. rotational symmetry, 3x4 = 4x3
end