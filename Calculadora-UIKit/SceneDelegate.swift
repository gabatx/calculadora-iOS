//
//  SceneDelegate.swift
//  Calculadora-UIKit
//
//  Created by gabatx on 5/1/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        // Realizamos una instancia de UIWindow pasándole la escena en la que estamos
        let window = UIWindow(windowScene: windowScene)
        // Creamos una instancia de nuestro ViewController
        let viewController = HomeViewController()
        // Le decimos a la ventana que su rootViewController es el que acabamos de crear
        window.rootViewController = viewController
        // Le decimos a la propiedad window de la escena que es la que acabamos de crear
        self.window = window
        // Hacemos visible la ventana
        window.makeKeyAndVisible()
    }
}

