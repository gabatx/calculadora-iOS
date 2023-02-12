//
//  CalculatorStrategy.swift
//  Calculadora-UIKit
//
//  Created by gabatx on 6/1/23.
//
import Foundation

protocol Operation {
    func perform(num1: Double, num2: Double) -> Double
}

class Addition: Operation {
    func perform(num1: Double, num2: Double) -> Double { num1 + num2 }
}

class Subtraction: Operation {
    func perform(num1: Double, num2: Double) -> Double { num1 - num2 }
}

class Multiplication: Operation {
    func perform(num1: Double, num2: Double) -> Double { num1 * num2 }
}

class Division: Operation {
    func perform(num1: Double, num2: Double) -> Double { num1 / num2 }
}

class Percent: Operation {
    func perform(num1: Double, num2: Double) -> Double { num1 * num2 / 100 }
}

class Calculator {
    let operation: Operation

    init(operation: Operation) {
        self.operation = operation
    }

    func calculate (_ num1: Double,_ num2: Double) -> Double {
        return operation.perform(num1: num1, num2: num2)
    }
}
