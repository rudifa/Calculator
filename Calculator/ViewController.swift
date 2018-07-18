//
//  ViewController.swift
//  Calculator
//
//  Created by Rudolf Farkas on 18.07.18.
//  Copyright © 2018 Rudolf Farkas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!

    var userIsTyping = false

    @IBAction func digitButtonTapped(_ sender: UIButton) {
        let digit = sender.currentTitle!
        print("\(digit) tapped")
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
        userIsTyping = false
        let mathSymbol = sender.currentTitle
        switch mathSymbol {
        case "π":
            displayValue = Double.pi
        case "√":
            displayValue = sqrt(displayValue)
        default:
            break
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

