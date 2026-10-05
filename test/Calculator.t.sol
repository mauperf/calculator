// SPDX-License-Identifier: MIT

pragma solidity 0.8.30;

import {Test} from "forge-std/Test.sol";
import {Calculator} from "../src/Calculator.sol";
contract TestCalculator is Test {
    Calculator calculator;

    function setUp() external {
        calculator = new Calculator(); 
    }

    // UNIT TESTING
    function testAdd() external {
        uint256 _firstNumber = 1;
        uint256 _secondNumber = 2;
        uint256 _result = _firstNumber + _secondNumber;

        uint256 _resultFunction = calculator.add(_firstNumber, _secondNumber);

        assert(_result == _resultFunction);
    }

    function testRevertSubtract_ResultCanNotBeNegative() external {
        uint256 _firstNumber = 1;
        uint256 _secondNumber = 2;

        vm.expectRevert(abi.encodeWithSelector(Calculator.ResultCanNotBeNegative.selector));
        calculator.subtract(_firstNumber, _secondNumber);
    }

    function testSubtract() external {
        uint256 _firstNumber = 3;
        uint256 _secondNumber = 2;
        uint256 _result = _firstNumber - _secondNumber;

        uint256 _resultFunction = calculator.subtract(_firstNumber, _secondNumber);

        assert(_result == _resultFunction);
    }

    function testMultiply() external {
        uint256 _firstNumber = 3;
        uint256 _secondNumber = 2;
        uint256 _result = _firstNumber * _secondNumber;

        uint256 _resultFunction = calculator.multiply(_firstNumber, _secondNumber);

        assert(_result == _resultFunction);
    }

    function testRevertDivide_DivisorCanNotBeZero() external {
        uint256 _firstNumber = 3;
        uint256 _secondNumber = 0;

        vm.expectRevert(abi.encodeWithSelector(Calculator.DivisorCanNotBeZero.selector));
        calculator.divide(_firstNumber, _secondNumber);
    }

    function testDivide() external {
        uint256 _firstNumber = 4;
        uint256 _secondNumber = 2;
        uint256 _result = _firstNumber / _secondNumber;

        uint256 _resultFunction = calculator.divide(_firstNumber, _secondNumber);

        assert(_result == _resultFunction);
    }

    // FUZZING TESTING
    function testFuzzingAdd(uint256 _firstNumber, uint256 _secondNumber) external {
        _secondNumber = bound(_secondNumber, 0, type(uint256).max - _firstNumber);
        uint256 _result = _firstNumber + _secondNumber;
        uint256 _resultFunction = calculator.add(_firstNumber, _secondNumber);

        assert(_result == _resultFunction);
    }

    function testFuzzingSubtract(uint256 _firstNumber, uint256 _secondNumber) external {
        _secondNumber = bound(_secondNumber, 0, _firstNumber);
        uint256 _result = _firstNumber - _secondNumber;
        uint256 _resultFunction = calculator.subtract(_firstNumber, _secondNumber);

        assert(_result == _resultFunction);
    }

    function testFuzzingMultiply(uint256 _firstNumber, uint256 _secondNumber) external {
        if (_firstNumber != 0) {
            _secondNumber = bound(_secondNumber, 0, type(uint256).max / _firstNumber);
        }
        uint256 _result = _firstNumber * _secondNumber;
        uint256 _resultFunction = calculator.multiply(_firstNumber, _secondNumber);

        assert(_result == _resultFunction);
    }

    function testFuzzingDivide(uint256 _firstNumber, uint256 _secondNumber) external {
        _secondNumber = bound(_secondNumber, 1, type(uint256).max);
        uint256 _result = _firstNumber / _secondNumber;
        uint256 _resultFunction = calculator.divide(_firstNumber, _secondNumber);

        assert(_result == _resultFunction);
    }
}