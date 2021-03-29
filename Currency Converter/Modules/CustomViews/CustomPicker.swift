//
//  CustomPicker.swift
//  Currency Converter
//
//  Created by Aaron Granado Amores on 27/03/2021.
//

import UIKit

class CustomPicker: UIPickerView {
    public var toolbar = CustomToolbar()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    func commonInit() {
        self.toolbar.senderView = self
    }
}
