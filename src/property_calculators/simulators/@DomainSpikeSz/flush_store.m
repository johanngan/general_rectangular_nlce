function flush_store(obj, quiet, force)
    % FLUSH_STORE()
    %   Flushes the storepath so calculations start from a clean slate.
    %   Useful for parameters changes, like changing the time-range or
    %   granularity of simulation. Set the quiet flag to suppress the
    %   file deletion messages. Set the force flag to true to suppress
    %   the confirmation.
    
    if nargin < 2
        quiet = false;
    end
    if nargin < 3
        force = false;
    end
    
    % Confirmation
    if ~force
        reply = lower(string(input(...
            'Are you sure you want to flush the store? y/n [n]: ', 's')));
        if reply == ""
            reply = "n";
        end
        if ~ismember(reply, ["y", "n"])
            fprintf('Invalid choice.\n');
            reply = "n";
        end
        if reply == "n"
            fprintf('Not flushing the store.\n');
            return;
        end
    end
    
    files = dir(sprintf('%s/*.txt', obj.storepath));
    for i = 1:length(files)
        if is_storefile(files(i).name)
            if ~quiet
                fprintf('Deleting: %s\n', files(i).name);
            end
            delete(sprintf('%s/%s', files(i).folder, files(i).name));
        end
    end
end

function b = is_storefile(filename)
    % Checks if filename is of the right format to be a store file.
    %   "{base}x{height}_{domain spike x}.txt"
    b = false;
    if regexp(filename, '\d+x\d+_\d+\.txt')
        b = true;
    end
end