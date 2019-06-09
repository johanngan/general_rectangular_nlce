classdef DomainSpikeSz < PropertyCalculator
    % DOMAINSPIKESZ Calculates z-magnetization for a domain-spike initial
    %   condition
    
    properties
        hamiltonian
        t_final
        t_res
        tol
        % Distance of measured site from domain spike
        % site_distance = site x - domain spike x
        site_distance
        storepath
    end
    
    methods
        function obj = DomainSpikeSz(hamiltonian, t_final, t_res, tol, ...
                site_distance, storepath)
            % DOMAINSPIKESZ(HAMILTONIAN, T_FINAL, T_RES, TOL,
            %   SITE_DISTANCE, STOREFILENAME)
            %   Construct an instance of this class.
            %
            %   hamiltonian(edges, psi) is a function handle encoding the
            %   action of the Hamiltonian under a given edge list. t_final
            %   is the final time for simulation. t_res is the time
            %   resolution. tol is the solver tolerance.
            %   site_distance is the distance from the domain spike to
            %   measure (Defaults to 0). storepath is the directory path
            %   for intermediate data file storage (Defaults to
            %   "store/DomainSpikeSz".
            if nargin < 5
                site_distance = 0;
            end
            if nargin < 6
                storepath = 'store/DomainSpikeSz';
            end
            obj.hamiltonian = hamiltonian;
            obj.t_final = t_final;
            obj.t_res = t_res;
            obj.tol = tol;
            obj.site_distance = site_distance;
            obj.storepath = storepath;
        end
        
        sum_sz = calculate(obj, rectangle_size);
        flush_store(obj, quiet, force);
    end
    
    methods(Access = private)
        simulate(obj, rectangle_size, domain_spike_x);
        psi0 = domain_spike_state(obj, rectangle_size, domain_spike_x);
        domain_spike_x = calc_domain_spike_x(obj, site_x);
        idx_r = reflect_idx(obj, idx, maxidx);
        storefilename = get_storefilename(obj, rectangle_size, domain_spike_x);
        key = get_key(obj, rectangle_size, domain_spike_x, site_x, site_y);
        sz = read_sz(obj, rectangle_size, domain_spike_x, site_x, site_y);
        write_sz(obj, rectangle_size, domain_spike_x, sz_map);
    end
end

