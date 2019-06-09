classdef O2Enumerator < Enumerator
    % O2ENUMERATOR Enumerates rectangles under the O2 scheme (number of
    % sites).
    
    methods
        function obj = O2Enumerator(map_filename)
            % O1ENUMERATOR(MAP_FILENAME) Construct an instance of this class
            %   Construct an Enumerator instance tied to a file given by
            %   map_filename. Any existing data will be read into the
            %   weights_map property, and future computations will append
            %   new weights matrices to the map file.
            %
            %   Default filename: "weights_map_O2.txt"

            if nargin < 1
                map_filename = "weights_map_O2.txt";
                warning(['No weights map filename specified.\n', ...
                    'Defaulting to "%s"'], map_filename);
            end
            
            obj = obj@Enumerator(map_filename);
        end
        
        rectangles = get_rectangle_list(obj, max_order);
    end
end

