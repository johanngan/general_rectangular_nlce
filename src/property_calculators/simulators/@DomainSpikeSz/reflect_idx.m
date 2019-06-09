function idx_r = reflect_idx(obj, idx, maxidx)
    % REFLECT_IDX(IDX, MAXIDX) calculates the reflection of idx. Used to
    %   take advantage of reflection symmetry of the domain spike system
    %   (in x and y).
    idx_r = maxidx - idx + 1;
end

