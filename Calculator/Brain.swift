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

    mutating func performOperation(_ symbol: String) {
        switch symbol {
        case "π":
            accumulator = Double.pi
        case "√":
            if let operand = accumulator {
                accumulator = sqrt(operand)
            }
        default:
            break
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
