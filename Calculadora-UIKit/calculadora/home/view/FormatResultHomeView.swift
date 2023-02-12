//
//  FormatResultHomeView.swift
//  Calculadora-UIKit
//
//  Created by gabatx on 11/1/23.
//

import Foundation
import UIKit

final class FormatResultHomeView{


    func controlSize(result: String, delegateOutletHomeView: CalculatorOutlet?){
        // Controlo que conforme se escriban números se vayan achicando los números
        if (result.count) > 8 {
            // Bajar el tamaño sin cambiar la fuente
            delegateOutletHomeView?.resultLabel.font = UIFont.systemFont(ofSize: 50, weight: .thin)
        }
    }

    // Controlo que no se escriban más de 9 dígitos
    func validateMaxCaracters(displayResult: String, kMaxNumber: Int) -> Bool {

        let count = displayResult.count

        switch (displayResult.contains("."), count) {
        case (true, let numCaracter) where numCaracter > kMaxNumber:
            return false
        case (false, let numCaracter) where numCaracter >= kMaxNumber:
            return false
        default:()
        }

        return true
    }

    func validateDecimal(delegateOutletHomeView: CalculatorOutlet?) -> Bool {
        return delegateOutletHomeView?.resultLabel.text?.contains(".") != nil
    }

}
