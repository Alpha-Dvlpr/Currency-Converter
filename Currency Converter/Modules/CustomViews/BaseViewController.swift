//
//  BaseViewController.swift
//  Currency Converter
//
//  Created by Aaron Granado Amores on 29/03/2021.
//

import UIKit
import Bond

class BaseViewController: UIViewController {
    
    var reloadEvent = Observable<Bool>(false)
    
    private let reloadButton: UIButton = {
        let button = UIButton()
        button.layer.backgroundColor = UIColor.systemBlue.cgColor
        button.layer.cornerRadius = 8
        button.setTitle(AppText.reloadButton.rawValue, for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showLoadingView(message: String) {
        self.view.startAnimating(message: message)
    }
    
    func hideLoadingView() {
        self.view.stopAnimating()
    }
    
    func showErrorView(errorMessage: String) {
        self.reloadEvent.value = false
        self.view.stopAnimating()
        
        self.reloadButton.addTarget(self, action: #selector(self.reloadButtonTapped(_:)), for: .touchUpInside)
        
        self.view.showErrorView(errorMesage: errorMessage, button: self.reloadButton)
    }
    
    @objc private func reloadButtonTapped(_ sender: UIButton) {
        self.view.hideErrorView()
        self.reloadEvent.value = true
    }
}
