//
//  AlamofireDataStore.swift
//  Currency Converter
//
//  Created by Aaron Granado Amores on 01/04/2021.
//

import Alamofire

class AlamofireDataStore {
    
    static let shared = AlamofireDataStore()
    
    func fecthCurrencyConversionRates(for currency: String = "", response: @escaping (Currencies?) -> Void) {
        let appending: String = currency.isEmpty ? "" : "?base=\(currency)"
        let endpoint: String = Endpoints.getCurrencies.rawValue.appending(appending)
        let alamofire = AF
        
        alamofire
            .request(endpoint, method: .get)
            .validate()
            .responseDecodable(of: Currencies.self) { data in
                response(data.value != nil ? data.value : nil )
            }
    }
}
