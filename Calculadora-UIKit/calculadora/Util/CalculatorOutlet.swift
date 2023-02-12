//
//  CalculatorOutlet.swift
//  Calculadora-UIKit
//
//  Created by Escuela de Tecnologias Aplicadas on 10/1/23.
//

import Foundation
import UIKit

protocol CalculatorOutlet {
    var resultLabel: UILabel!      { get set }
    var acButton: UIButton!        { get set }
    var percentButton: UIButton!   { get set }
    var divideButton: UIButton!    { get set }
    var multiplyButton: UIButton!  { get set }
    var substractButton: UIButton! { get set }
    var addButton: UIButton!       { get set }
}
