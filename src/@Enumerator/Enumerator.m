classdef(Abstract) Enumerator < handle
    % ENUMERATOR Performs rectangle enumeration tasks
    %   Computes the weights matrix of a given rectangle size,
    %   which is an (s x 3) matrix where each row corresponds to a
    %   subrectangle (including the full rectangle itself), and the columns
    %   having values [base, height, coefficient]. The "weight" of the
    %   rectangle (under the NLCE definition) is given by sum(c_s*P_s),
    %   where c_s is the coefficient (3rd column) of a given subrectangle,
    %   and P_s is some extensive property computed on that given
    %   subrectangle.
    %
    %   Also computes and stores (in a file) the weights map, which has
    %   keys corresponding to all previously encountered rectangle sizes
    %   [base, height]. The values are the weights matrix of each rectangle.
    %
    %   If it exists, the weights matrix file is read in before any of the
    %   above computation, and the computation is finished with dynamic
    %   programming.
    
    properties
        map_filename
    end
    
    properties(Access = protected)
        weights_map
    end
    
    methods
        function obj = Enumerator(map_filename)
            % ENUMERATOR(MAP_FILENAME) Construct an instance of this class
            %   Construct an Enumerator instance tied to a file given by
            %   map_filename. Any existing data will be read into the
            %   weights_map property, and future computations will append
            %   new weights matrices to the map file.
            %
            %   Default filename: "weights_map.txt" in the current
            %   directory

            if nargin < 1
                map_filename = "weights_map.txt";
                warning(['No weights map filename specified.\n', ...
                    'Defaulting to "%s"'], map_filename);
            end
            
            obj.map_filename = map_filename;
            obj.weights_map = obj.read_weights_map();
        end
        
        nlce_coeffs = get_nlce_coeffs(obj, nlce_order);
        calc_weights(obj, base, height);
        subrectangles = get_subrectangles(obj, base, height);
        
        flush_weights_map(obj);
    end
    
    methods(Abstract)
        rectangles = get_rectangle_list(obj, max_order);
    end
    
    methods(Access = private)
        weights_map = read_weights_map(obj, warn);
        write_weights_map(obj);
        weights_matrix = add_weights(obj, rectangles);
    end
    
    methods(Static, Access = private)
        key = rect_to_key(rect);
        rect = key_to_rect(key);
    end
end

