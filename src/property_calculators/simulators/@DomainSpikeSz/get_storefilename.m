function storefilename = get_storefilename(obj, rectangle_size, domain_spike_x)
    % STOREFILENAME = GET_STOREFILENAME(RECTANGLE_SIZE, DOMAIN_SPIKE_X)
    %   Forms the store file name from the rectangle size and domain spike
    %   position.
    storefilename = sprintf('%s/%ix%i_%i.txt', obj.storepath, ...
        rectangle_size(1), rectangle_size(2), domain_spike_x);
end