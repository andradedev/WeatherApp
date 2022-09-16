//
//  BaseViewController.swift
//  WeatherApp
//
//  Created by Felipe Andrade on 16/09/22.
//

import UIKit
import SDKNetwork

protocol ViewModelDelegate: AnyObject {
    func set(isLoading: Bool)
    func setError(_ error: RequestError)
}

extension ViewModelDelegate where Self: BaseViewController {
    func set(isLoading: Bool) {
        showLoading(isOn: isLoading)
    }
    
    func setError(_ error: RequestError) {
        showError(error: error)
    }
}

class BaseViewController: UIViewController {
    var loadingView: UIView?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func showLoading(isOn: Bool) {
        loadingView?.removeFromSuperview()
        loadingView = nil
        
        if isOn {
            let spinner = UIActivityIndicatorView(style: .large)
            spinner.translatesAutoresizingMaskIntoConstraints = false
            
            let loadingView = UIView()
            
            let blurEffect = UIBlurEffect(style: .light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            loadingView.addSubview(blurEffectView)
            
            blurEffectView.constraintFullyToSuperView(loadingView)
            
            loadingView.addSubview(spinner)
            view.addSubview(loadingView)
            
            spinner.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor).isActive = true
            spinner.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor).isActive = true
            
            loadingView.constraintFullyToSuperView(view)
            
            spinner.startAnimating()
            self.loadingView = loadingView
        }
    }
    
    func showError(error: RequestError) {
        let alert = UIAlertController(title: "Error", message: error.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
}

