function psi0 = domain_spike_state(obj, rectangle_size, domain_spike_x)
    % PSI0 = DOMAIN_SPIKE_STATE(RECTANGLE_SIZE, DOMAIN_SPIKE_X)
    %   Calculates the state vector for a domain spike state on a
    %   rectangular lattice of given size, at position domain_spike_x. The
    %   domain spike is spin-up, with the background being spin-down.
    %
    %   Lattice is enumerated from left-to-right, top-to-bottom. Bitwise
    %   encoding for the basis states is such that the nth bit corresponds
    %   to the nth site. Spin-down is 0 and spin-up is 1.
    
    n = prod(rectangle_size);
    psi0 = zeros(2^n, 1);
    
    if domain_spike_x == 0    % 0 means no domain spike
        psi0(1) = 1;    % All spin-down
    else
        domain_spike_idx = 1;    % +1 to make 1-indexed
        for i = 1:rectangle_size(2)
            site_idx = (i-1)*rectangle_size(1) + (domain_spike_x - 1);   % 0-indexed
            domain_spike_idx = domain_spike_idx + 2^site_idx;
        end
        psi0(domain_spike_idx) = 1;  % Select the domain-spike basis state
    end
end

