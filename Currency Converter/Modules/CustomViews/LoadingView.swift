//
//  LoadingView.swift
//  Currency Converter
//
//  Created by Aaron Granado Amores on 29/03/2021.
//

import UIKit

class LoadingView: UIViewController {
    private let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .white
        indicator.startAnimating()
        indicator.autoresizingMask = [
            .flexibleLeftMargin, .flexibleRightMargin,
            .flexibleTopMargin, .flexibleBottomMargin
        ]
        return indicator
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 14)
        label.numberOfLines = 3
        return label
    }()
    
    private let blur: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.8
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        self.blur.frame = self.view.bounds
        self.view.insertSubview(self.blur, at: 0)
        
        self.view.addSubview(self.indicator)
        self.indicator
            .centerHorizontallyWithParent(safeArea: true)
            .centerVerticallyWithParent(safeArea: true)
        
        self.view.addSubview(self.messageLabel)
        self.messageLabel
            .alignBelow(to: self.indicator, constant: 8)
            .centerHorizontallyWithParent(safeArea: true)
            .width(constant: 150)
    }
    
    func setupMessage(message: String) {
        self.messageLabel.text = message
    }
}
