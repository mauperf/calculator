# Calculator

A simple Solidity smart contract that performs the four basic arithmetic operations on unsigned integers, built and tested with [Foundry](https://book.getfoundry.sh/).

## Features

- **Addition, subtraction, multiplication and division** of `uint256` values.
- **Last result storage**: every operation saves its result in the public `lastResult` variable.
- **Events** emitted for each operation, including both operands and the result.
- **Custom errors** for invalid inputs instead of generic reverts.

## Contract overview

[`src/Calculator.sol`](src/Calculator.sol)

### Functions

| Function | Description | Reverts when |
|---|---|---|
| `add(uint256 a, uint256 b)` | Returns `a + b` (sum) | The result overflows `uint256` |
| `subtract(uint256 a, uint256 b)` | Returns `a - b` (difference) | `a < b` → `ResultCanNotBeNegative()` |
| `multiply(uint256 a, uint256 b)` | Returns `a * b` (product) | The result overflows `uint256` |
| `divide(uint256 a, uint256 b)` | Returns `a / b` (quotient, rounded down) | `b == 0` → `DivisorCanNotBeZero()` |
| `lastResult()` | Returns the result of the last successful operation | — |

### Events

```solidity
event Addition(uint256 firstNumber, uint256 secondNumber, uint256 sum);
event Subtraction(uint256 firstNumber, uint256 secondNumber, uint256 difference);
event Multiplication(uint256 firstNumber, uint256 secondNumber, uint256 product);
event Division(uint256 firstNumber, uint256 secondNumber, uint256 quotient);
```

### Errors

```solidity
error DivisorCanNotBeZero();
error ResultCanNotBeNegative();
```

## Getting started

### Requirements

- [Foundry](https://book.getfoundry.sh/getting-started/installation)

### Installation

```shell
git clone --recurse-submodules https://github.com/mauperf/calculator.git
cd calculator
forge build
```

## Testing

```shell
forge test
```

The test suite in [`test/Calculator.t.sol`](test/Calculator.t.sol) includes:

- **Unit tests** for each operation with fixed values.
- **Revert tests** for subtraction with a negative result and division by zero.
- **Fuzz tests** for each operation with random inputs. Inputs are constrained with `bound()` so they always stay in a valid range (no overflow, no underflow and no division by zero).

Useful options:

```shell
forge test -vvv          # Verbose output with traces for failing tests
forge coverage           # Test coverage report
forge snapshot           # Gas snapshot
```

## Project structure

```
├── src
│   └── Calculator.sol       # Calculator contract
├── test
│   └── Calculator.t.sol     # Unit and fuzz tests
├── lib                      # Dependencies (forge-std)
└── foundry.toml             # Foundry configuration
```

## License

This project is licensed under the MIT License.
