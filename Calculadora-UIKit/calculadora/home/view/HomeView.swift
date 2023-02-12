//
//  HomeView.swift
//  Calculadora-UIKit
//
//  Created by gabatx on 6/1/23.
//

import UIKit


final class HomeView: UIView, CalculatorDelegate, CalculatorOutlet {

    var homeViewController = HomeViewController()

    // REFERENCIAS:
    @IBOutlet weak var resultLabel: UILabel!

    // Botones para operaciones:
    @IBOutlet weak var acButton: UIButton!
    @IBOutlet weak var plusMinusButton: UIButton!
    @IBOutlet weak var percentButton: UIButton!
    @IBOutlet weak var divideButton: UIButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var substractButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var equalButton: UIButton!

    // Botones numéricos:
    @IBOutlet weak var decimalButton: UIButton!
    @IBOutlet weak var number0Button: UIButton!
    @IBOutlet weak var number1Button: UIButton!
    @IBOutlet weak var number2Button: UIButton!
    @IBOutlet weak var number3Button: UIButton!
    @IBOutlet weak var number4Button: UIButton!
    @IBOutlet weak var number5Button: UIButton!
    @IBOutlet weak var number6Button: UIButton!
    @IBOutlet weak var number7Button: UIButton!
    @IBOutlet weak var number8Button: UIButton!
    @IBOutlet weak var number9Button: UIButton!

    // Este inicializador sirve para crear la vista desde código
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView() // Llamamos a la función que abre el archivo el xib
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        homeViewController.delegateUpdateResultHomeView = self
        homeViewController.delegateOutletHomeView = self
        // Abriendo el archivo .xib
        let view = Bundle.main.loadNibNamed("HomeView", owner: self, options: nil)?.first as! UIView
        // Añadiendo la vista al view de la clase
        self.addSubview(view)
        // Ajustando el tamaño de la vista
        view.frame = self.bounds
        // Ajustando el tamaño de la vista al tamaño del view de la clase
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        // Aplico estilo a los botones
        self.roundButton()
    }

    // ActionButton:

    // Botones para operaciones: (He cambiado todos los sender a UIButton)
    @IBAction func acActionButton(_ sender: UIButton) {
        homeViewController.processAC()
    }

    @IBAction func equalActionButton(_ sender: UIButton) {
        homeViewController.processResult(sender: sender)
    }

    @IBAction func plusMinusActionButton(_ sender: UIButton) {
        homeViewController.pulseAddPlusMinus(sender: sender)
    }

    @IBAction func percentActionButton(_ sender: UIButton) {
        homeViewController.pulseOperator(operation: .percent, sender: sender)

    }

    @IBAction func divideActionButton(_ sender: UIButton) {
        homeViewController.pulseOperator(operation: .division, sender: sender)
    }

    @IBAction func multiplyActionButton(_ sender: UIButton) {
        homeViewController.pulseOperator(operation: .multiplication, sender: sender)
    }

    @IBAction func substractActionButton(_ sender: UIButton) {
        homeViewController.pulseOperator(operation: .subtraction, sender: sender)
    }

    @IBAction func addActionButton(_ sender: UIButton) {
        homeViewController.pulseOperator(operation: .addition, sender: sender)
    }

    @IBAction func decimalActionButton(_ sender: UIButton) {
        homeViewController.pulseNumber(sender: sender)
    }

    // Botones numéricos:
    @IBAction func buttonAction(_ sender: UIButton) {
        homeViewController.pulseNumber(sender: sender)
    }

    func updateResult(result: String) {
        resultLabel.text! = result
    }

    func roundButton(){
        acButton.round()
        plusMinusButton.round()
        percentButton.round()
        divideButton.round()
        multiplyButton.round()
        substractButton.round()
        addButton.round()
        equalButton.round()
        decimalButton.round()
        number0Button.round()
        number1Button.round()
        number2Button.round()
        number3Button.round()
        number4Button.round()
        number5Button.round()
        number6Button.round()
        number7Button.round()
        number8Button.round()
        number9Button.round()
    }
}
