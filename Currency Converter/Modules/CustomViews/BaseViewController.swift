//
//  BaseViewController.swift
//  Currency Converter
//
//  Created by Aaron Granado Amores on 29/03/2021.
//

import UIKit

class BaseViewController: UIViewController {
    private let loaderView = LoadingView()
    private let errorView = ErrorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showLoadingView(message: String) {
        self.loaderView.setupMessage(message: message)
        self.loaderView.modalPresentationStyle = .overFullScreen
        self.loaderView.modalTransitionStyle = .crossDissolve
        self.present(self.loaderView, animated: true, completion: nil)
    }
    
    func hideLoadingView() {
        self.loaderView.dismiss(animated: true, completion: nil)
    }
    
    func showErrorView(errorMessage: String, reload: Bool, reloadMessage: String?) {
        self.errorView.modalPresentationStyle = .overFullScreen
        self.errorView.modalTransitionStyle = .crossDissolve
        self.present(self.errorView, animated: true, completion: nil)
    }
    
    func reloadViewData() {
        self.errorView.dismiss(animated: true, completion: nil)
    }
}
