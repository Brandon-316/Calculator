//
//  CalculatorLogic.swift
//  Calculator
//
//  Created by Brandon Mahoney on 2/24/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation


struct CalculatorLogic {
    
    private var total: Double?
    
    private var number: Double?
    
    private var intermediateCalculation: (n1: Double, calcMethod: String)?
    
    mutating func setNumber(_ number: Double) {
        self.number = number
    }
    
    private func performTwoNumCalculation(n2: Double) -> Double? {
        if let n1 = intermediateCalculation?.n1,
            let operation = intermediateCalculation?.calcMethod {
            print(print("Symbol \(operation) is running through operation"))
            switch operation {
                case "+": return n1 + n2
                case "-": return n1 - n2
                case "×": return n1 * n2
                case "÷": return n1 / n2
                default: fatalError("The operation does not match any cases.")
            }
        }
        return nil
    }
    
    mutating func calculate(symbol: String) -> Double? {
        if let n = number {
            switch symbol {
                case "+/-": return n * -1
                case "AC":
                    intermediateCalculation = nil
                    number = nil
                    return 0
                case "%": return n * 0.1
                case "=": return performTwoNumCalculation(n2: n)
                
                default: intermediateCalculation = (n1: n, calcMethod: symbol)
                    print("Symbol \(symbol) set in calculate()")
            }
        }
        return nil
    }
    
}
