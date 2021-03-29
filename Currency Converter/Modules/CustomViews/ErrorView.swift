//
//  ErrorView.swift
//  Currency Converter
//
//  Created by Aaron Granado Amores on 30/03/2021.
//

import UIKit

class ErrorView: UIViewController {
    
    private let reloadButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.layer.backgroundColor = UIColor.systemBlue.cgColor
        button.setTitle(AppText.reloadButton.rawValue, for: .normal)
        return button
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 14)
        label.numberOfLines = 3
        return label
    }()
    
    private let reloadLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 12)
        label.numberOfLines = 3
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}
