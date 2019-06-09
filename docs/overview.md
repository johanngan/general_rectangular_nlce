The `NlceCalculator` is the "master" class. It calculates the rectangular NLCE. It has three dependencies that must be injected upon initialization.

1. An `Enumerator` performs rectangle enumeration within each NLCE order.
    - An `O1Enumerator` enumerates rectangles by average side length
    - An `O2Enumerator` enumerates rectangles by number of sites
2. A `PropertyCalculator` performs the calculation of some extensive property on each rectangle.
    - A `Simulator` calculates properties by direct simulation and measurement of a system under a Hamiltonian and initial state, using some numerical solver.
        - The Hamiltonian and initial states may be translated around relative to the rectangles in any given property calculation, and each may involve some internal states (especially in the case of disorder), so they are specified to the Simulator as factory classes.
            - The Hamiltonian can also be explicitly time-dependent
        - The measurement is a function handle that measures a state vector for some property. The measurement operation may be translated around, similar to the Hamiltonian and initial states. Translation can be used to encode site-local measurements (e.g. the magnetization at one specific site).
        - A `Solver` class, initialized with some parameters (e.g. time range, tolerance), takes some concrete Hamiltonian and initial state, and performs the actual time stepping routine and computes some observable at each step.
            - A `OdeSolver` uses the built-in ODE solving suite (ode45 and ode113) for time stepping
            - A `LanczosSolver` uses the Lanczos (Krylov-space) method for time stepping
    - A `MonteCarloSampler` calculates properties through Monte Carlo sampling (To be implemented)
3. A `Writer` writes the final NLCE output to some file.