//
//  Currency.swift
//  Currency Converter
//
//  Created by Aaron Granado Amores on 02/04/2021.
//

class Currency {
    var code: String = ""
    var value: Double = 0
    
    init(code: String, value: Double) {
        self.code = code
        self.value = value
    }
}

class Currencies: Decodable {
    private var privateRates: [String: Double]
    var base: String
    var rates: [Currency] {
        return privateRates.map { (key, value) -> Currency in
            return Currency(code: key, value: value)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case base = "base"
        case privateRates = "rates"
    }
}
