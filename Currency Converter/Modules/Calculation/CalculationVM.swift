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
    private var _conversions: [Currency] = []
    var filteredConversions: [Currency] = []
    
    init() {
        self.status.value = .loading(AppText.fetchingCurrencies.rawValue)
        self.getFromRealm()
    }
    
    func getFromRealm() {
        if let currencies = RealmCurrenciesDataStore.shared.getCurrencies(), currencies.rates.count != 0 {
            self.finishLoading(currencies: currencies)
        } else {
            self.fetchData()
        }
    }
    
    func fetchData(for currencyCode: String = "", and value: Double = 0, reload: Bool = false) {
        self.status.value = .loading(
            currencyCode == ""
                ? AppText.fetchingCurrencies.rawValue
                : String.init(format: AppText.fetchingConversions.rawValue, currencyCode)
        )
        
        AlamofireDataStore.shared.fecthCurrencyConversionRates(for: currencyCode) { (currencies) in
            guard let currencies = currencies else {
                self.status.value = .error(AppText.errorFetching.rawValue)
                return
            }
            
            self.finishLoading(code: currencyCode, value: value, currencies: currencies, reload: reload)
        }
    }
    
    func searchConversion(matching code: String? = "", reload: Bool = false) {
        self.filteredConversions = self._conversions.filter {
            guard let code = code, !code.isEmpty else { return true }
            return $0.code.lowercased().contains(code.lowercased())
        }
        
        self.status.value = .view(true)
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
        self._conversions = []
        self.filteredConversions = []
        
        self.currencies
            .filter { $0.code != self.base && $0.code != "-" }
            .forEach { self._conversions.append(Currency(code: $0.code, value: $0.value * value)) }
        
        self.filteredConversions = self._conversions
        self.status.value = .view(true)
    }
    
    private func saveCurrencies(currencies: Currencies) {
        self._currencies = []
        self._currencies.append(Currency(code: "-", value: 0))
        self._currencies.append(contentsOf: currencies.rates)
        self.base = currencies.base
        
        RealmCurrenciesDataStore.shared.addCurrencies(appModel: currencies)
    }
}
