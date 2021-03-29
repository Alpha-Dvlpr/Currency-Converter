//
//  CustomToolbar.swift
//  Currency Converter
//
//  Created by Aaron Granado Amores on 29/03/2021.
//

import UIKit

protocol ToolbarDelegate: class {
    func cancelTapped(_ sender: UIView?)
    func doneTapped(_ sender: UIView?)
}

class CustomToolbar: UIToolbar {
    public weak var toolbarDelegate: ToolbarDelegate?
    public weak var senderView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        let doneButton = UIBarButtonItem(
            title: AppText.okButton.rawValue,
            style: .plain,
            target: self,
            action: #selector(self.doneTapped)
        )
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(
            title: AppText.cancelButton.rawValue,
            style: .plain,
            target: self,
            action: #selector(self.cancelTapped)
        )
        
        self.barStyle = .default
        self.isTranslucent = true
        self.tintColor = .systemBlue
        self.sizeToFit()
        self.setItems([cancelButton, spaceButton, doneButton], animated: false)
        self.isUserInteractionEnabled = true
    }
    
    @objc func doneTapped() {
        self.toolbarDelegate?.doneTapped(self.senderView)
    }
    
    @objc func cancelTapped() {
        self.toolbarDelegate?.cancelTapped(self.senderView)
    }
}
