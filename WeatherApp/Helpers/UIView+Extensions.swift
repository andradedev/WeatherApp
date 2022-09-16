//
//  UIView+Extensions.swift
//  WeatherApp
//
//  Created by Felipe Andrade on 16/09/22.
//

import UIKit

extension UIView {
    func constraintFullyToSuperView(_ superView: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
    }
}
