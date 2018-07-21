//
//  ViewController.swift
//  Calculator
//
//  Created by Rudolf Farkas on 18.07.18.
//  Copyright © 2018 Rudolf Farkas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var brain = Brain()

    @IBOutlet weak var display: UILabel!

    var userIsTyping = false
    var decimalPointSeen = false
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        userIsTyping = false
        decimalPointSeen = false
        brain.clearAll()
        display.text = "0"
    }

    @IBAction func decimalPointTapped(_ sender: UIButton) {
        if userIsTyping {
            if !decimalPointSeen {
                let currentDisplayText = display.text
                display.text = currentDisplayText! + "."
            }
        } else {
            display.text = "0."
            userIsTyping = true
        }
        decimalPointSeen = true
    }

    @IBAction func digitButtonTapped(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsTyping {
            let currentDisplayText = display.text
            display.text = currentDisplayText! + digit
        } else {
            display.text = digit
            userIsTyping = true
        }
    }

    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }

    @IBAction func performOperation(_ sender: UIButton) {
        if userIsTyping {
            brain.setOperand(displayValue)
            userIsTyping = false
            decimalPointSeen = false
        }
        if let mathSymbol = sender.currentTitle {
            brain.performOperation(mathSymbol)
        }
        if let result = brain.result {
            displayValue = result
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

