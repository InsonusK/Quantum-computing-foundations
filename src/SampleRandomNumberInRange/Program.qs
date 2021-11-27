namespace SampleRandomNumberInRange {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;
    
    operation GenerateRandomBit() : Result {
        // Allocate a qubit.
        use q = Qubit();
        // Put the qubit to superposition.
        H(q);
        // It now has a 50% chance of being measured 0 or 1.
        // Measure the qubit value.
        return M(q);
    }

    operation SampleRandomNumberInRange(max : Int) : Int {
        mutable output = 0; 
        // function BitSizeI (a : Int) : Int - (Microsoft.Quantum.Math) - For a non-negative integer a, returns the number of bits required to represent a.
        let bitSize = BitSizeI(max);
        repeat {
            mutable bits = [];             
            for idxBit in 1..bitSize {
                set bits += [GenerateRandomBit()]; 
            }
            set output = ResultArrayAsInt(bits);
            if (output > max) {
                Message($"Generate value {output}, it is bigger than {max}. Try Again");
            }
        } until (output <= max);
        return output;
    }

    @EntryPoint()
    operation SampleRandomNumber() : Int {
        let max = 50;
        Message($"Sampling a random number between 0 and {max}: ");
        return SampleRandomNumberInRange(max);
    }
}
