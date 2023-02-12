//
//  UIButtonExtension.swift
//  Calculadora-UIKit
//
//  Created by gabatx on 7/1/23.
//

import UIKit


extension UIButton {

    // Borde redondo
    func round() {
        // Da la posibilidad de redondear bordes a cualquier botón
        layer.cornerRadius = bounds.height / 2
        clipsToBounds = true
    }

    // Brillo.
    func shine() {
        // Coge la vista y la anima para que aparezca y desaparezca muy rápidamente
        UIView.animate(withDuration: 0.05, animations: {
            self.alpha = 0.5
        }, completion: { (completion) in
            UIView.animate(withDuration: 0.1){
                self.alpha = 1
            }
        })
    }


}
