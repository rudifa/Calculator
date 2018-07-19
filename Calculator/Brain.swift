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

    private enum Operation {
        case constant(Double)
        case unaryOp((Double) -> Double)
    }

    private var operations: Dictionary<String, Operation> = [
        "π": .constant(Double.pi),
        "e": .constant(M_E),
        "√": .unaryOp(sqrt),
        "cos": .unaryOp(cos),
        "±": .unaryOp({-$0})
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
            }
        }
    }

    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }

    var result: Double? {
        get {
            return accumulator
        }
    }

}
