//
//  ConversionCell.swift
//  Currency Converter
//
//  Created by Aaron Granado Amores on 02/04/2021.
//

import UIKit

class ConversionCell: UITableViewCell {
    
    @IBOutlet weak var currencyCodeLabel: UILabel!
    @IBOutlet weak var integerPartLabel: UILabel!
    @IBOutlet weak var decimalPartLabel: UILabel!
    
    func configureCell(with currency: Currency) {
        self.currencyCodeLabel.text = currency.code
        self.integerPartLabel.text = self.getIntegerPartString(value: currency.value)
        self.decimalPartLabel.text = self.getDecimalPartString(value: currency.value)
    }
    
    func getIntegerPartString(value: Double) -> String {
        let integerValue = Int(value)
        return String(integerValue)
    }
    
    func getDecimalPartString(value: Double) -> String {
        let stringValue = String(format: "%f", value)
        var tempValue = stringValue
        
        if let range: Range<String.Index> = tempValue.range(of: ".") {
            let index: Int = tempValue.distance(from: tempValue.startIndex, to: range.lowerBound)
            
            for _ in 0..<index { tempValue.removeFirst() }
            
            if tempValue.count < 5 {
                for _ in 0...(5 - tempValue.count) { tempValue.append("0") }
            }
        } else {
            tempValue = ".0000"
        }
        
        return String(tempValue.prefix(5))
    }
}
