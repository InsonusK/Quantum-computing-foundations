namespace ExploringGroversSearch {
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Intrinsic;
    
    operation MarkColorEquality(c0 : Qubit[], c1 : Qubit[], target : Qubit) : Unit is Adj+Ctl {
        within {
            // Iterate over pairs of qubits in matching positions in c0 and c1.
            for (q0, q1) in Zipped(c0, c1) {
                // Compute XOR of bits q0 and q1 in place (storing it in q1).
                CNOT(q0, q1);
            }
        } apply {
            // If all computed XORs are 0, the bit strings are equal - flip the state of the target.
            (ControlledOnInt(0, X))(c1, target);
        }
    }


    @EntryPoint()
    operation ShowColorEqualityCheck() : Unit {
        use (c0, c1, target) = (Qubit[2], Qubit[2], Qubit());
        // Leave register c0 in the |00⟩ state.

        // Prepare a quantum state that is a superposition of all possible colors on register c1.
        ApplyToEach(H, c1);

        // Output the initial state of qubits c1 and target. 
        // We do not include the state of qubits in the register c0 for brevity, 
        // since they will remain |00⟩ throughout the program.
        Message("The starting state of qubits c1 and target:");
        DumpRegister((), c1 + [target]);

        // Compare registers and mark the result in target qubit.
        MarkColorEquality(c0, c1, target);

        Message("");
        Message("The state of qubits c1 and target after the equality check:");
        DumpRegister((), c1 + [target]);

        // Return the qubits to |0⟩ state before releasing them.
        ResetAll(c1 + [target]);
    }

    operation SolveGraphColoringProblem() : Unit {
        // Graph description: hardcoded from the example
        // The number of vertices is an integer
        let nVertices = 5;
        // The list of edges is an array of tuples, and each tuple is a pair of integers
        let edges = [(0, 1), (0, 2), (0, 3), (1, 2), (1, 3), (2, 3), (3, 4)];

        // Graph coloring: hardcoded from the example
        let coloring = [false, false, true, false, false, true, true, true, true, false];
        let colors = ["red", "green", "blue", "yellow"];

        // Interpret the coloring: split the bit string into 2-bit fragments and convert them to colors.
        // Преобразует coloring в двумерный массив n*2, разделив его на chunk-и длинной 2: [[false,false], [true,false], [false,true], [true, true], [true,false]]
        let colorBits = Chunks(2, coloring);

        for i in 0 .. nVertices - 1 {
            // берем colorBits по порядковому номеру вершины от 0 до 4 (5 вершин Vertices) 
            // преобразуем chunk размером 2 (пример [false, false]) в int число colorIndex
            let colorIndex = BoolArrayAsInt(colorBits[i]);
            // Используем colorIndex как индекс массива colors, чтобы присвоить вершине (Vertices) цвет
            Message($"Vertex {i} - color #{colorIndex} ({colors[colorIndex]})");
        }
    }
}
