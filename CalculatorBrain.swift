//
//  CalculatorBrain.swift
//  First IOS app
//
//  Created by Yuan Zheng on 21/7/16.
//  Copyright © 2016 Yuan Zheng. All rights reserved.
//

import Foundation


class CalculatorBrain {
    
    private var accumulator = 0.0
    
  
    
    func setOperand(operand: Double) {
        print("SetOperand \(accumulator)")
        accumulator = operand
    }
    
    var operations: Dictionary<String, Operation> = [
        "PI" : Operation.Constant(M_PI),
        "e"  : Operation.Constant(M_E),
        "√"  : Operation.UnaryOperation(sqrt),
        "cos": Operation.UnaryOperation(cos),
        "×"  : Operation.BinaryOperation({ $0 * $1}),
        "÷"  : Operation.BinaryOperation({ $0 / $1}),
        "+"  : Operation.BinaryOperation({ $0 + $1}),
        "−"  : Operation.BinaryOperation({ $0 - $1}),
        "="  : Operation.Equals
    ]
    
    enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                print("BinaryOperation \(accumulator)")
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
            }
        }
    }
    
    private func executePendingBinaryOperation() {
        if pending != nil {
          
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            print("accumulator-after \(accumulator)")
            pending = nil
        }
    }

    private var pending: PendingBinaryOperationInfo? //Only when there's info, it will be set, or it is nil.

    
    //class pass by reference, live somewhere, pass the a pointer to it, pass the same thing | struct pass by value, when pass it, we copy it
    struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
}