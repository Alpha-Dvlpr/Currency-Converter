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
    var base: String = "-"
    var conversions: [Currency] = []
    
    init() {
        self.status.value = .loading(AppText.fetchingCurrencies.rawValue)
        self.getFromRealm()
    }
    
    func getFromRealm() {
       let count = 0
        
        if count == 0 {
            self.fetchData()
        } else {
//            self.finishLoading(currencies: <#T##Currencies#>)
        }
    }
    
    func fetchData(for currencyCode: String = "", and value: Double = 0, reload: Bool = false) {
        self.status.value = .loading(
            currencyCode == ""
                ? AppText.fetchingCurrencies.rawValue
                : String.init(format: AppText.fetchinConversions.rawValue, currencyCode)
        )
        
        AlamofireDataStore.shared.fecthCurrencyConversionRates(for: currencyCode) { (currencies) in
            guard let currencies = currencies else {
                self.status.value = .error(AppText.errorFetching.rawValue)
                return
            }
            
            self.finishLoading(code: currencyCode, value: value, currencies: currencies, reload: reload)
        }
    }
    
    private func finishLoading(code: String = "", value: Double = 0, currencies: Currencies, reload: Bool = false) {
        self.saveCurrencies(currencies: currencies)
        
        if !code.isEmpty {
            self.calculateConversions(value: value)
        } else {
            self.status.value = .view(reload)
        }
    }
    
    private func calculateConversions(value: Double) {
        self.conversions = []
        
        self.currencies
            .filter { $0.code != self.base && $0.code != "-" }
            .forEach { self.conversions.append(Currency(code: $0.code, value: $0.value * value)) }
        
        self.status.value = .view(true)
    }
    
    private func saveCurrencies(currencies: Currencies) {
        self._currencies = []
        self._currencies.append(Currency(code: "-", value: 0))
        self._currencies.append(contentsOf: currencies.rates)
        self.base = currencies.base
    }
}
