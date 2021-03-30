//
//  ViewExtension.swift
//  Currency Converter
//
//  Created by Aaron Granado Amores on 30/03/2021.
//

import UIKit
import Bond

extension UIView {
    var backColor: CGColor {
        return UIColor { (trait: UITraitCollection) -> UIColor in
            return trait.userInterfaceStyle == .dark
                ? .systemGray
                : .darkGray
        }.cgColor
    }
    
    func startAnimating(color: UIColor = .systemBlue, message: String?) {
        if self.viewWithTag(1000000) != nil { return }
        
        self.isUserInteractionEnabled = false
        
        let container = UIStackView()
        container.axis = .vertical
        container.bounds = CGRect.init(x: 0, y: 0, width: 240, height: 240)
        container.spacing = 16
        container.alignment = .center
        container.distribution = .equalCentering
        
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = color
        indicator.center = CGPoint(x: container.frame.width / 2, y: container.frame.height / 2)
        indicator.startAnimating()
        
        container.addArrangedSubview(indicator)
        
        if message != nil {
            let label = UILabel()
            label.textAlignment = .center
            label.font = .boldSystemFont(ofSize: 14)
            label.numberOfLines = 2
            label.text = message
            label.textColor = .black
            
            container.addArrangedSubview(label)
        }
        
        let backgroundView = UIView()
        backgroundView.bounds = CGRect(x: 0, y: 0, width: 250, height: 125)
        backgroundView.center = self.center
        backgroundView.layer.backgroundColor = backColor
        backgroundView.layer.cornerRadius = 12
        backgroundView.tag = 1000000
        
        backgroundView.addSubview(container)
        container
            .centerHorizontallyWithParent(safeArea: true)
            .centerVerticallyWithParent(safeArea: true)
        
        self.addSubview(backgroundView)
    }
    
    func stopAnimating() {
        if let backgroudView = self.viewWithTag(1000000) {
            backgroudView.removeFromSuperview()
        }
        
        self.isUserInteractionEnabled = true
    }
    
    func showErrorView(errorMesage: String, button: UIButton) {
        if self.viewWithTag(2000000) != nil { return }
        
        let backgroundView = UIView()
        backgroundView.bounds = CGRect(x: 0, y: 0, width: 250, height: 125)
        backgroundView.center = self.center
        backgroundView.layer.backgroundColor = backColor
        backgroundView.layer.cornerRadius = 12
        backgroundView.tag = 2000000
        
        self.addSubview(backgroundView)
        backgroundView
            .matchParentVertically(safeArea: true)
            .matchParentHorizontally(safeArea: true)
        
        backgroundView.addSubview(button)
        button
            .centerHorizontallyWithParent(safeArea: true)
            .centerVerticallyWithParent(safeArea: true)
            .width(constant: 200)
        
        let errorLabel = UILabel()
        errorLabel.textAlignment = .center
        errorLabel.font = .boldSystemFont(ofSize: 14)
        errorLabel.text = errorMesage
        errorLabel.textColor = .black
        errorLabel.numberOfLines = 3

        backgroundView.addSubview(errorLabel)
        errorLabel
            .width(constant: 250)
            .centerHorizontallyWithParent(safeArea: true)
            .alignAbove(to: button, constant: 24)
    }
    
    func hideErrorView() {
        if let backgroudView = self.viewWithTag(2000000) {
            backgroudView.removeFromSuperview()
        }
    }
}
