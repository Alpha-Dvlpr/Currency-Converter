//
//  CalculationVM.swift
//  Currency Converter
//
//  Created by Aaron Granado Amores on 27/03/2021.
//

import Bond

enum Status {
    case view(Bool)
    case loading(String)
    case error(String)
}

class CalculationVM {
    
    var status = Observable<Status>(.view(false))
    private var _currencies: [Currency] = []
    var currencies: [Currency] {
        return self._currencies.count == 0
            ? [Currency(code: "-", value: 0)]
            : self._currencies.sorted(by: { $0.code < $1.code })
    }
    
    init() {
        // get from realm.
        //
        // if none
        //     fetch from api and save to realm
        //
        // insert them into this '_currencies' array
        // reload picker with this '_currencies' array
        
        self.fetchData()
    }
    
    func fetchData(for currencyCode: String = "", reload: Bool = false) {
        self.status.value = .loading(currencyCode == "" ? "Fetching needed data" : "Calculating...")
        
        AlamofireDataStore.shared.fecthCurrencyConversionRates(for: currencyCode) { (currencies) in
            guard let currencies = currencies else {
                self.status.value = .error("Error al obtener las divisas")
                return
            }
            
            self._currencies = []
            self._currencies.append(Currency(code: "-", value: 0))
            self._currencies.append(contentsOf: currencies)
            
            self.status.value = .view(reload)
        }
    }
    
    func calculateConversions() {
        
    }
}
