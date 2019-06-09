TODO

General description

TransInvtSim - cheaper simulation for when the Hamiltonian and initial state are translationally invariant, and the measurement is extensive
AsymmetricSim - full simulation for fully asymmetric systems (Hamiltonian or initial state), and possibly for site-local measurements

Idea is to make a new Simulator subclass for different symmetry optimizations, but otherwise keep things general to work on any fitting Hamiltonian, initial state, and measurement.

*Other ideas:
(YReflectSim) - for systems that have reflection symmetry in the y direction, but not the x direction. E.g.: a spin domain wall
(XYReflectSim) - for systems that have reflection symmetry in both the x and y directions. E.g.: a spin domain spike
(RotInvtSim) - for rotationally invariant but not translationally invariant systems (intrinsincally has XY reflection symmetry, but also an extra symmetry due to XY interchangeability). E.g.: a single flipped spin

Lists of implemented solvers, hamiltonians, initial states, and measurements in the simulators/ subdirectory
    - Describe trans_invt vs. asymmetric hamiltonians, initial states
        - ONLY use trans_invt for TransInvtSim, and make sure at least one is asymmetric for AsymmetricSim
    - Describe extensive vs. local measurements
        - ONLY use extensive for TransInvtSim, not sure if extensive will work for AsymmetricSim
        - extensive measurements can include sums of site-local properties, such as magnetizations or NN correlations