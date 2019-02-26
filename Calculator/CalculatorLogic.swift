//
//  CalculatorLogic.swift
//  Calculator
//
//  Created by Brandon Mahoney on 2/24/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation


struct CalculatorLogic {
    
    private var total: Double = 0
    
    private var number: Double?
    
    private var intermediateCalculation: (n1: Double, calcMethod: String)?
    
    mutating func setNumber(_ number: Double) {
        self.number = number
    }
    
    private mutating func performTwoNumCalculation(n2: Double) -> Double? {
        
        if let n1 = intermediateCalculation?.n1,
            let operation = intermediateCalculation?.calcMethod {
            switch operation {
                case "+": total = n1 + n2
                case "-": total = n1 - n2
                case "×": total = n1 * n2
                case "÷": total = n1 / n2
                default: fatalError("The operation does not match any cases.")
            }
            intermediateCalculation?.n1 = total
            return total
        }
        return nil
    }
    
    mutating func calculate(symbol: String, equalsPushed: inout Bool) -> Double? {
        if let n = number {
            switch symbol {
                case "+/-": return n * -1
                case "AC":
                    intermediateCalculation = nil
                    number = nil
                    equalsPushed = false
                    return 0
                case "%": return n * 0.01
                case _ where symbol == "=" && equalsPushed:
                    intermediateCalculation?.n1 = total
                    return performTwoNumCalculation(n2: n)
                case "=":
                    equalsPushed = true
                    return performTwoNumCalculation(n2: n)
                default: intermediateCalculation = (n1: n, calcMethod: symbol)
            }
        }
        return nil
    }
    
}
