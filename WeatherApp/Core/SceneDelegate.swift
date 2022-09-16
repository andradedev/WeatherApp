//
//  SceneDelegate.swift
//  WeatherApp
//
//  Created by Felipe Andrade on 16/09/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var coordinator: MainCoordinator?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        coordinator = MainCoordinator(window: UIWindow(windowScene: scene))
        coordinator?.start()
    }
}

