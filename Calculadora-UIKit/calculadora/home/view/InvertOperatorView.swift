//
//  InvertOperatorView.swift
//  Calculadora-UIKit
//
//  Created by Escuela de Tecnologias Aplicadas on 10/1/23.
//

import Foundation
import UIKit


class InvertOperatorView {

    func activeInvertViewOperator(operationType: OperationType ,delegate: CalculatorOutlet) {
        
        // Primero desactiva todos los operadores y después
        deactiveAllOperator(delegate: delegate)

        switch operationType {
        case .addition:
            delegate.addButton.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
            delegate.addButton.setTitleColor(UIColor(red: 0.98, green: 0.58, blue: 0.00, alpha: 1.00), for: .normal)
        case .subtraction:
            delegate.substractButton.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
            delegate.substractButton.setTitleColor(UIColor(red: 0.98, green: 0.58, blue: 0.00, alpha: 1.00), for: .normal)
        case .multiplication:
            delegate.multiplyButton.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
            delegate.multiplyButton.setTitleColor(UIColor(red: 0.98, green: 0.58, blue: 0.00, alpha: 1.00), for: .normal)
        case .division:
            delegate.divideButton.backgroundColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00)
            delegate.divideButton.setTitleColor(UIColor(red: 0.98, green: 0.58, blue: 0.00, alpha: 1.00), for: .normal)
        default:()
        }
    }

    func deactiveAllOperator(delegate: CalculatorOutlet){
        delegate.addButton.backgroundColor = UIColor(red: 0.98, green: 0.58, blue: 0.00, alpha: 1.00)
        delegate.addButton.setTitleColor(UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00), for: .normal)

        delegate.substractButton.backgroundColor = UIColor(red: 0.98, green: 0.58, blue: 0.00, alpha: 1.00)
        delegate.substractButton.setTitleColor(UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00), for: .normal)

        delegate.multiplyButton.backgroundColor = UIColor(red: 0.98, green: 0.58, blue: 0.00, alpha: 1.00)
        delegate.multiplyButton.setTitleColor(UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00), for: .normal)

        delegate.divideButton.backgroundColor = UIColor(red: 0.98, green: 0.58, blue: 0.00, alpha: 1.00)
        delegate.divideButton.setTitleColor(UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.00), for: .normal)
    }

}
