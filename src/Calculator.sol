// SPDX-License-Identifier: MIT

pragma solidity 0.8.30;

contract Calculator {

    uint256 public lastResult;

    event Addition(uint256 firstNumber, uint256 secondNumber, uint256 sum);
    event Subtraction(uint256 firstNumber, uint256 secondNumber, uint256 difference);
    event Multiplication(uint256 firstNumber, uint256 secondNumber, uint256 product);
    event Division(uint256 firstNumber, uint256 secondNumber, uint256 quotient);

    error DivisorCanNotBeZero();
    error ResultCanNotBeNegative();

    constructor() {}

    function add(uint256 _firstNumber, uint256 _secondNumber) external returns (uint256 _sum) {
        _sum = _firstNumber + _secondNumber;
        lastResult = _sum;

        emit Addition(_firstNumber, _secondNumber, _sum);
    }

    function subtract(uint256 _firstNumber, uint256 _secondNumber) external returns (uint256 _difference) {
        if (_firstNumber < _secondNumber) revert ResultCanNotBeNegative();
        _difference = _firstNumber - _secondNumber;
        lastResult = _difference;

        emit Subtraction(_firstNumber, _secondNumber, _difference);
    }

    function multiply(uint256 _firstNumber, uint256 _secondNumber) external returns (uint256 _product) {
        _product = _firstNumber * _secondNumber;
        lastResult = _product;

        emit Multiplication(_firstNumber, _secondNumber, _product);
    }

    function divide(uint256 _firstNumber, uint256 _secondNumber) external returns (uint256 _quotient) {
        if (_secondNumber == 0) revert DivisorCanNotBeZero();
        _quotient = _firstNumber / _secondNumber;
        lastResult = _quotient;

        emit Division(_firstNumber, _secondNumber, _quotient);
    }


}