//
//  HomeViewController.swift
//  Calculadora-UIKit
//
//  Created by gabatx on 6/1/23.
//

// - El view retiene al presenter y se genera retail cycle que es un problema de memoria que debe ser mitigado con property modifiers (weak, unowned, etc)

import UIKit

final class HomeViewController: UIViewController {

    // MARK: - PROPIEDADES

    var delegateOutletHomeView: CalculatorOutlet?
    var delegateUpdateResultHomeView: CalculatorDelegate?

    private var homeView: HomeView?
    private var invertOperation = InvertOperatorView()
    private var formatResultHomeView = FormatResultHomeView()
    private var operationType: OperationType = .none
    private var memoryTemp: Double?
    private var numberWrite: Double?
    private var isProcessing: Bool = false
    private var pulseEqual: Bool = false
    private var didOperation: Bool = false
    private var hasDecimal: Bool = false
    private var isPulseOperator: Bool = false
    private let kMaxNumber: Int = 12

    // MARK: - CICLO DE VIDA:

    override func loadView() {
        homeView = HomeView()
        view = homeView
    }

    // MARK: - RECIBE PULSACIÓN

    func pulseNumber(sender button: UIButton){
        button.shine()
        guard let displayResult = Double((delegateOutletHomeView?.resultLabel.text)!) else { return }
        if (!self.validateDisplay(sender: button, displayResult: displayResult)) { return }
        numberWrite = Double((delegateOutletHomeView?.resultLabel.text!)!)
    }

    func pulseOperator(operation: OperationType, sender button: UIButton){

        // Si está pendiente una operación sin darle aún al igual
        if isProcessing{
            memoryTemp = operateValues()
        }

        // Activa la operación
        didOperation = true
        // Resetea los valores
        pulseEqual = false
        hasDecimal = false
        // Defino el tipo de operación
        operationType = operation

        // Si viene nil significa que acaba de empezar y guardamos el número marcado
        if memoryTemp == nil {
            memoryTemp = numberWrite
        }

        // Estilo - invierte el color del operador pulsado:
        invertOperation.activeInvertViewOperator(operationType: operationType, delegate: delegateOutletHomeView!)

        // Estilo - Brilla al pulsar:
        button.shine()
    }

    func pulseAddPlusMinus(sender button: UIButton) {

        button.shine()
        let numberShown = Double((delegateOutletHomeView?.resultLabel.text)!)!
        let resultString = validateSuffix(resultString: (delegateOutletHomeView?.resultLabel.text)!)

        if (numberShown > 0) {
            delegateOutletHomeView?.resultLabel.text! = "-\(String(describing: resultString))"
        }
        if (numberShown < 0) {
            let resultStringReformated = validateSuffix(resultString: String(Double(resultString)! * -1))
            // Le quito el negativo multiplicando por -1
            delegateOutletHomeView?.resultLabel.text! = "\(resultStringReformated)"
        }
        numberWrite = Double((delegateOutletHomeView?.resultLabel.text!)!)!
        if pulseEqual {
            memoryTemp = numberWrite
        }
    }

    // MARK: - VALIDACIONES

    private func validateDisplay(sender button: UIButton, displayResult: Double) -> Bool {

        if !formatResultHomeView.validateMaxCaracters(displayResult: (delegateOutletHomeView?.resultLabel.text)!, kMaxNumber: kMaxNumber) { return false }
        invertOperation.deactiveAllOperator(delegate: delegateOutletHomeView!)

        guard var keystroke = button.titleLabel?.text! else {return false}
        formatResultHomeView.controlSize(result: (delegateOutletHomeView?.resultLabel.text)!, delegateOutletHomeView: delegateOutletHomeView)

        // Si ya se ha realizado una operación valida si el resulado tiene un decimal
        if memoryTemp != nil {
            hasDecimal = formatResultHomeView.validateDecimal(delegateOutletHomeView: delegateOutletHomeView)
        }

        // Escribe el punto si no está escrito y es pulsado el botón de punto
        switch (keystroke, hasDecimal) {
        case (".", false):
            keystroke = "."
            hasDecimal = true
        case (".", true):
            keystroke = ""
        default:()
        }

        // Borra el cero inicial y escribe un número
        if displayResult == 0 && !hasDecimal {
            delegateOutletHomeView?.resultLabel.text! = ""
            delegateOutletHomeView?.resultLabel.text! += "\(String(describing: keystroke))"
            formatTextACButton()
            return true
        }

        // Cuando se pulse un operador, se borra el número que se escribió
        if didOperation {
            isProcessing = true
            delegateOutletHomeView?.resultLabel.text! = ""
            delegateOutletHomeView?.resultLabel.text! += "\(String(describing: keystroke))"
            didOperation = false
            formatTextACButton()
            return true
        }

        // Si se pulsa el igual, se borra el número que se escribió
        if pulseEqual {
            isProcessing = true
            if !hasDecimal {
                delegateOutletHomeView?.resultLabel.text! = ""
            }

            delegateOutletHomeView?.resultLabel.text! += "\(String(describing: keystroke))"
            pulseEqual = false
            // Se resetea la memoria temporal
            if !didOperation {
                memoryTemp = nil
            }
            return true
        }

        delegateOutletHomeView?.resultLabel.text! += "\(String(describing: keystroke))"

        return true
    }

    func operateValues() -> Double? {
        var result:Double = 0
        guard let memory = self.memoryTemp else { return nil }
        let numberWrite = self.numberWrite ?? 0

        switch operationType {
        case .addition:
            let calculator = Calculator(operation: Addition())
            result = calculator.calculate(memory, numberWrite)
        case .subtraction:
            let calculator = Calculator(operation: Subtraction())
            result = calculator.calculate(memory, numberWrite)
        case .multiplication:
            let calculator = Calculator(operation: Multiplication())
            result = calculator.calculate(memory, numberWrite)
        case .division:
            let calculator = Calculator(operation: Division())
            result = calculator.calculate(memory, numberWrite)
        case .percent:
            let calculator = Calculator(operation: Percent())
            result = calculator.calculate(memory, numberWrite)
        default:()
        }
        return result
    }

    func processResult(sender button: UIButton) {

        // Obtiene el resultado
        guard let result = operateValues() else { return }

        // Si el resultado tiene un .0, lo quita.
        let resultString = validateSuffix(resultString: String(result))

        // Valida que se escriba 9 dígitos
        if !formatResultHomeView.validateMaxCaracters(displayResult: resultString, kMaxNumber: kMaxNumber) { return }
        // Valida
        formatResultHomeView.controlSize(result: resultString, delegateOutletHomeView: delegateOutletHomeView)

        // Se lo pasa a la pantalla
        delegateUpdateResultHomeView?.updateResult(result: resultString)
        // Se le pasa el resulado a la memoria
        self.memoryTemp = result
        pulseEqual = true
        isProcessing = false
        hasDecimal = false

        // Estilo:
        invertOperation.deactiveAllOperator(delegate: delegateOutletHomeView!)
        button.shine()
    }

    private func validateSuffix(resultString: String) -> String {
        if resultString.contains("."){
            // Si es decimal redondea a 4 decimales, si tiene solo ceros los elimina
            return String(format: "%g", Double(String(format: "%.4f", Double(resultString)!))!)
        }
         return resultString
    }

    func resetCalculation(){
        memoryTemp = nil
        numberWrite = nil
        operationType = .none
        hasDecimal = false
        pulseEqual = false
        isProcessing = false
    }

    // MARK: - AC BUTTON

    func processAC() {
        acRestarValueDefault()
        invertOperation.deactiveAllOperator(delegate: delegateOutletHomeView!)
        resetCalculation()
        delegateOutletHomeView?.resultLabel.font = UIFont.systemFont(ofSize: 100, weight: .thin)
    }

    func acRestarValueDefault(){
        delegateOutletHomeView?.acButton.setTitle("AC", for: .normal)
        delegateOutletHomeView?.resultLabel.text = "0"
        hasDecimal = false
    }

    func formatTextACButton(){
        // Controlo que cuando se pulse AC se borre el número y se escriba C en vez de AC
        if (delegateOutletHomeView?.resultLabel.text!.count)! > 0 {
            delegateOutletHomeView?.acButton.setTitle("C", for: .normal)
        } else {
            delegateOutletHomeView?.acButton.setTitle("AC", for: .normal)
        }
    }
    
}
