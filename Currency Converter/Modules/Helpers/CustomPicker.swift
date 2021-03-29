//
//  CustomPicker.swift
//  Currency Converter
//
//  Created by Aaron Granado Amores on 27/03/2021.
//

import UIKit

protocol PickerDelegate: class {
    func cancelTapped()
    func doneTapped()
}

class CustomPicker: UIPickerView {
    public var toolbar: UIToolbar?
    public weak var toolbarDelegate: PickerDelegate?
    
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
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = .systemBlue
        toolBar.sizeToFit()
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        self.toolbar = toolBar
    }
    
    @objc func doneTapped() {
        self.toolbarDelegate?.doneTapped()
    }
    
    @objc func cancelTapped() {
        self.toolbarDelegate?.cancelTapped()
    }
}
