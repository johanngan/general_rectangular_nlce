classdef Writer
    % WRITER Writes to files
    
    properties
        writemode
    end
    
    methods
        function obj = Writer(writemode)
            % WRITER(WRITEMODE) Construct an instance of this class
            %   writemode is a file permission string for the mode of file
            %   writing.
            %
            %   'w+' (default) - write + create
            %   'w' - write
            %   'W' - write with automatic buffer flushing
            %   'a+' - append + create
            %   'a' - append
            %   'A' - append with automatic buffer flushing
            
            if nargin < 1
                writemode = 'w+';
            end
            if ~ismember(writemode, ["w+", "w", "W", "a+", "a", "A"])
                error('Invalid write mode.');
            end
            obj.writemode = writemode;
        end

        function write(obj, data, filename)
            % WRITE(DATA, FILENAME) writes data to a specified file
            %   data should be a numeric array. Written to file in the
            %   output format from mat2str().
            
            % Create the containing folder if it doesn't exist
            [path, ~, ~] = fileparts(filename);
            if string(path) ~= "" && ~exist(path, 'dir')
                mkdir(path);
            end
            
            fid = fopen(filename, obj.writemode);
            fprintf(fid, mat2str(data));
            fclose(fid);
        end
    end
end

