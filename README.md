# HoareCost

A formal verification and asymptotic complexity analysis tool developed in Haskell. This project extends traditional Hoare Logic to include execution costs, generating Verification Conditions (VCs) that are automatically validated by the **Z3** SMT solver via the **SBV** library.

## Prerequisites

To build and run this project, you will need the following tools installed on your machine:
* **GHC** and **Cabal**
* **Z3 SMT Solver**

## How to Build and Run

In your terminal, from the project's root directory:

1.  **Build the project:**
    ```bash
    cabal build
    ```

2.  **Run the test cases:**
    You can pass the path of any `.hc` file located in the examples folder to the compiler.
    ```bash
    cabal run compiler ./compiler/examples/division.hc
    ```

## Project Structure

The project is modularized, separating the core VC generation library from the compiler executable:

```text
HoareCost/
├── compiler/               # Compiler executable source code
│   ├── examples/           # Test algorithms in HC language (assign, division, sum, swap)
│   └── Main.hs             # Entry point for the .hc file compiler
├── src/                    # Core Library (Formal Verification Engine)
│   ├── Lexer/              # Lexical analysis rules for the HC language
│   ├── Parser/             # Syntactic analysis rules for the HC language
│   ├── Syntax.hs           # Data structures (AST) definition for commands and expressions
│   ├── VCGen.hs            # Verification Condition Generator and WPC calculation
│   ├── Solver.hs           # VC translation and SBV/Z3 integration
│   ├── Oracle.hs           # Capture system for loop Invariants, Variants, and Costs
│   ├── Variables.hs        # Variable environment definition and manipulation
│   └── Utils.hs            # Utilities and support module
├── HoareCost.cabal         # Dependency and build configurations
└── Main.hs                 # Root entry point
```

## Loop Usage Examples

#Example 1: **Division Algorithm**

For this example, the following values must be passed to the **Oracle**:

| Parameter | Value |
| :--- | :--- |
| **Invariant** | `((X == (Q * Y) + R) and ((Y > 0) and (R >= 0)))` |
| **Variant** | `X - R` |
| **Num. Iterations**| `X` |
| **Cost Function** | `10` |

#Example 2: **Summation Algorithm**

For this example, the following values must be passed to the **Oracle**:

| Parameter | Value |
| :--- | :--- |
| **Invariant** | `((T <= ((I - 1) * N)) and ((I >= 1) and (I <= (N + 1))))` |
| **Variant** | `I` |
| **Num. Iterations**| `N` |
| **Cost Function** | `12` |