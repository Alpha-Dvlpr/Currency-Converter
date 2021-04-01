//
//  AlamofireDataStore.swift
//  Currency Converter
//
//  Created by Aaron Granado Amores on 01/04/2021.
//

import Foundation
import Alamofire

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
    var rates: [Currency] {
        return privateRates.map { (key, value) -> Currency in
            return Currency(code: key, value: value)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case privateRates = "rates"
    }
}

class AlamofireDataStore {
    
    static let shared = AlamofireDataStore()
    
    func fecthCurrencyConversionRates(for currency: String = "", response: @escaping ([Currency]?) -> Void) {
        AF.request(
            currency == ""
                ? Endpoints.standardConversions.rawValue
                : Endpoints.givenCurrency.rawValue.appending(currency),
            method: .get
        )
        .validate()
        .responseDecodable(of: Currencies.self) { data in
            if let resp = data.value {
                response(resp.rates)
            } else {
                response(nil)
            }
        }
    }
}
