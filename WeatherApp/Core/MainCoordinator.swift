//
//  MainCoordinator.swift
//  WeatherApp
//
//  Created by Felipe Andrade on 16/09/22.
//

import UIKit

class MainCoordinator {
    var window: UIWindow?
    var navigation: UINavigationController?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigation = UINavigationController(rootViewController: mainViewController())
        self.navigation = navigation
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
    
    func mainViewController() -> UIViewController {
        let view = WeatherViewController(viewModel: WeatherViewModel())
        // No control for routes needed in this sample app
        // a `viewModel.coordinatorDelegate = self` could have been inplemented here if needed
        return view
    }
}
