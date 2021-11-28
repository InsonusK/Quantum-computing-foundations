namespace QuantumRNG {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Diagnostics;
    @EntryPoint()
    operation GenerateRandomBit() : Result {
        // Allocate a qubit.
        use q = Qubit();
        Message("Initialized qubit:");
        DumpMachine();
        Message(" ");
        // Put the qubit to superposition.
        H(q);
        Message("Qubit after applying H:");
        DumpMachine();
        Message(" ");
        // It now has a 50% chance of being measured 0 or 1.
        // Measure the qubit value.
        let randomBit = M(q);
        Message("Qubit after the measurement:");
        DumpMachine();
        Message(" ");
        Reset(q);
        Message("Qubit after resetting:");
        DumpMachine();
        Message(" ");
        return randomBit;
    }
}
