classdef SolverResults < handle
    % SOLVERRESULTS Holds results from an Solver class.
    %
    % Solver needs a separate handle class to hold results so as to be
    % mutable as just an input parameter to a function, as required by
    % some solvers (e.g. the built-in ODE suite).
    %
    % SolverResults class needs a struct property that can hold arbitrary
    % and flexible named fields that can be accessed by string names.
    properties
        data
    end
    
    methods
        function obj = SolverResults()
            % SIMULATOR()
            % Construct an instance of this class.
            obj.data = struct;
        end
    end
end

