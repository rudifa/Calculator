//
//  Brain.swift
//  Calculator
//
//  Created by Rudolf Farkas on 19.07.18.
//  Copyright © 2018 Rudolf Farkas. All rights reserved.
//

import Foundation

struct Brain {

    private var accumulator: Double?
    private var pendingBinaryOp: PendingBinaryOp?

    private enum Operation {
        case constant(Double)
        case unaryOp((Double) -> Double)
        case binaryOp((Double,Double) -> Double)
        case equals
    }

    private var operations: Dictionary<String, Operation> = [
        "π": .constant(Double.pi),
        "e": .constant(M_E),
        "√": .unaryOp(sqrt),
        "cos": .unaryOp(cos),
        "±": .unaryOp({-$0}),
        "×": .binaryOp({$0 * $1}),
        "÷": .binaryOp({$0 / $1}),
        "+": .binaryOp({$0 + $1}),
        "-": .binaryOp({$0 - $1}),
        "=": .equals
   ]

    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOp(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            case .binaryOp(let function):
                if accumulator != nil {
                    pendingBinaryOp = PendingBinaryOp(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOp()
            }
        }
    }

    private struct PendingBinaryOp {
        let function: (Double,Double) -> Double
        let firstOperand: Double
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }

    private mutating func performPendingBinaryOp() {
        if pendingBinaryOp != nil && accumulator != nil {
            accumulator = pendingBinaryOp!.perform(with: accumulator!)
            pendingBinaryOp = nil
        }
    }

    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }

    mutating func clearAll() {
        accumulator = nil
        pendingBinaryOp = nil
    }

    var result: Double? {
        get {
            return accumulator
        }
    }

}
