function tagged = tag_filename(filename, nlce_order)
    % TAGGED = TAG_FILENAME(FILENAME, NLCE_ORDER)
    %   Tag a filename with its NLCE order by inserting "_n{order}" just
    %   before the extension. An empty filename yields empty tagged
    %   filename.
    tagged = filename;
    
    % Replace decimals with underscores
    tag = "_n" + replace(string(nlce_order), '.', '_');
    
    % Insert the tag directly before the extension
    insert_pos = find(char(filename) == '.', 1, 'last');
    if ~isempty(insert_pos)
        tagged = insertBefore(filename, ...
            find(char(filename) == '.', 1, 'last'), tag);
    elseif string(filename) ~= ""
        % If no extension and nonempty, just insert tag at the end
        tagged = strcat(filename, tag);
    end
end