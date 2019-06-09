% Supporting function, not an actual operator
function idx = sigma_z_idx_to_negate(i, j, n)
% Determines which indexes to negate for the sigma_zi*sigma_zj product,
% given n bits.
%
% Constructs all possible configurations of bits not including bits
% i and j, then generates the indexes to negate by flipping only bit i and
% only bit j.
    % Force i < j
    if i > j
        temp = i;
        i = j;
        j = temp;
    end
    
    % Left and middle sections
    idx = bitshift(0:(2^(n-j)-1), j) + bitshift(0:(2^(j-1-i)-1), i)';
    
    % Right section
    idx = idx(:) + (0:(2^(i-1)-1));
    
    % Flip i xor j
    idx = bitxor(idx(:), 2.^[i-1, j-1]);
    
    % - Collapse matrix of possibilities to column
    % - Offset by 1 because MATLAB uses 1-indexing
    idx = idx(:) + 1;
end