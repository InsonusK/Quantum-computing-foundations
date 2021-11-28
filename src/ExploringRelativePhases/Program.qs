namespace ExploringRelativePhases {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Measurement;

    @EntryPoint()
    operation TestInterference2(direction: String) : Unit {
        use q = Qubit();
        if (direction == "Y") {
            Y(q);
        }
        else {
            X(q);
        }
        H(q);
        DumpMachine();
        Reset(q);
    }
}
