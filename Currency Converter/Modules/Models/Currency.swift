//
//  Currency.swift
//  Currency Converter
//
//  Created by Aaron Granado Amores on 02/04/2021.
//

import RealmSwift

class Currency {
    var code: String = ""
    var value: Double = 0
    
    init(code: String, value: Double) {
        self.code = code
        self.value = value
    }
    
    init(realmModel: RCurrency) {
        self.code = realmModel.code
        self.value = realmModel.value
    }
}

class RCurrency: Object {
    @objc dynamic var identifier: Int = 0
    @objc dynamic var code: String = ""
    @objc dynamic var value: Double = 0
    
    var dict: [String: Double] { return [self.code: self.value] }
    
    convenience init(appModel: Currency) {
        self.init()
        
        self.code = appModel.code
        self.value = appModel.value
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
    
    init(realmModel: RCurrencies) {
        self.base = realmModel.base
        self.privateRates = [:]
        
        Array(realmModel.rates).forEach { rate in
            self.privateRates[rate.code] = rate.value
        }
    }
}

class RCurrencies: Object {
    @objc dynamic var identifier: Int = 0
    @objc dynamic var base: String = ""
    var rates = List<RCurrency>()
    
    convenience init(appModel: Currencies) {
        self.init()
        
        self.base = appModel.base
        self.rates.removeAll()
        self.rates.append(
            objectsIn: appModel.rates.map { appModel -> RCurrency in
                return RCurrency.init(appModel: appModel)
            }
        )
    }
}
