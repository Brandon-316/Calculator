//
//  ViewController.swift
//  Calculator
//
//  Created by Brandon Mahoney on 2/24/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Properties
    private var calculator = CalculatorLogic()
    private var isFinishedTypingNumber: Bool = true
    private var equalsPushed: Bool = false
    private var displayValue: Double {
        get {
            guard let displayDouble = Double(displayLabel.text!) else { fatalError("cannot convert display label to Double.") }
            let isInt = floor(displayDouble) == displayDouble
            
            if !isInt {
                displayLabel.text = String(displayDouble)
            } else {
                displayLabel.text = String(Int(displayDouble))
            }
            
            
            guard let number = Double(displayLabel.text!) else { fatalError("Cannot convert display label to Double.") }
            return number
        }
        set {
            let isInt = floor(newValue) == newValue
            
            if !isInt {
                displayLabel.text = String(newValue)
            } else {
                displayLabel.text = String(Int(newValue))
            }
        }
    }
    
    //MARK: - Outlets
    @IBOutlet weak var displayLabel: UILabel!
    
    
    //MARK: - Actions
    @IBAction func calcButtonPressed(_ sender: UIButton) {
        
        //What should happen when a non-number button is pressed
        
        isFinishedTypingNumber = true
        
        if !equalsPushed {
            calculator.setNumber(displayValue)
        }
        
        if let calcMethod = sender.currentTitle {
            if let result = calculator.calculate(symbol: calcMethod, equalsPushed: &equalsPushed) {
                displayValue = result
            }
        }
    }

    
    @IBAction func numButtonPressed(_ sender: UIButton) {
        //What should happen when a number is entered into the keypad
        if let value = sender.currentTitle {
            //Check if entering a new number
            if isFinishedTypingNumber {
                switch value {
                    case ".": displayLabel.text = "0."
                    default: displayLabel.text = value
                }
                isFinishedTypingNumber = false
            } else {
                switch value {
                    case ".":
                        if (displayLabel.text?.contains("."))! {
                            return
                        }
                        fallthrough
                    default: displayLabel.text?.append(contentsOf: value)
                }
            }
        }
    
    }

}

