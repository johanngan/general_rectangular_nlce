classdef(Abstract) Simulator < PropertyCalculator
    % SIMULATOR Calculates properties through some time-stepping simulation
    %   scheme of the state vector under some Hamiltonian.
    %
    %   Can read and write files to some path to avoid redundant
    %   calculation.
    
    properties
        solver
        measurement
        hamiltonian_factory
        initial_state_factory
        storepath
    end
    
    methods
        function obj = Simulator(solver, measurement, ...
                hamiltonian_factory, initial_state_factory, storepath)
            % SIMULATOR(SOLVER, MEASUREMENT, HAMILTONIAN_FACTORY,
            %   INITIAL_STATE_FACTORY, STOREPATH)
            %   Construct an instance of this class.
            %
            %   solver is a Solver instance to perform time-stepping.
            %   measurement is a function handle that performs some
            %       measurement on a state vector with some spatial shift
            %       on a rectangle.
            %   hamiltonian_factory is a HamiltonianFactory instance that
            %       creates a hamiltonian function with some spatial shift.
            %   initial_state_factory is a StateFactory instance that
            %       creates an initial state vector with some spatial shift.
            %   storepath is the directory path
            %       for intermediate data file storage.

            obj.solver = solver;
            obj.measurement = measurement;
            obj.hamiltonian_factory = hamiltonian_factory;
            obj.initial_state_factory = initial_state_factory;
            obj.storepath = storepath;
        end
        
        property = calculate(obj, rectangle_size);
        flush_store(obj, quiet, force);
    end
    
    methods(Abstract, Access = protected)
        % Get the system and measurement displacements (as equal-length
        % cell arrays of displacement vectors) over which property
        % calculation must be summed for the total calculation on a given
        % rectangle.
        [system_displacements, measurement_displacements] = ...
            get_displacements_for_prop_calculation(obj, rectangle_size);
        % Get the displacements (as a cell array of displacement vectors)
        % that correspond to distinct measurements that can be made by this
        % Simulator under simulation of a given rectangle size and system
        % displacement.
        measurement_displacements = ...
            get_measurement_displacements_for_single_sim(obj, ...
            rectangle_size, system_displacement);
    end
    
    methods(Access = protected)
        rectangle_size = symmetry_transform(obj, rectangle_size);
    end
    
    methods(Access = private)
        simulate(obj, rectangle_size, system_displacement);
        storefile = get_storefile(obj, rectangle_size, system_displacement);
        prop = read_store(obj, rectangle_size, system_displacement, ...
            measurement_displacement);
        write_store(obj, rectangle_size, system_displacement, prop_map);
    end
    
    methods(Static, Access = private)
        key = get_key(measurement_displacement);
    end
end

