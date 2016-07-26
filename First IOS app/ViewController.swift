//
//  ViewController.swift
//  First IOS app
//
//  Created by Yuan Zheng on 20/7/16.
//  Copyright © 2016 Yuan Zheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var display: UILabel!
    
    private var userInTheMiddleOfTyping = false
    
    @IBAction private func touchDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
        }
        userInTheMiddleOfTyping = true
    }
    
    private var displayValue: Double {
        get {
            return Double(display.text!)!  //might not be convertable so need ! 
        }
        set {
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
  
    @IBAction private func performOperation(sender: UIButton) {
        if userInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            print("Controller:performOperation \(displayValue)")
            userInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            print("Controller:performOperation \(mathematicalSymbol)")
            brain.performOperation(mathematicalSymbol)
            displayValue = brain.result
        }
        
    }

    @IBAction private func reset() {
        userInTheMiddleOfTyping = false
        brain.setOperand(0.0)
        displayValue = brain.result
    }
}

