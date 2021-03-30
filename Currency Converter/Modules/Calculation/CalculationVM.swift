//
//  CalculationVM.swift
//  Currency Converter
//
//  Created by Aaron Granado Amores on 27/03/2021.
//

import Bond

enum Status {
    case view
    case loading(String)
    case error(String)
}

class CalculationVM {
    
    var status = Observable<Status>(.view)
    private var _currencies: [String] = []
    var currencies: [String] {
        return self._currencies.count == 0
            ? ["-"]
            : self._currencies
    }
    var conversions: [Double] = []
    
    func fetchData(for currencyCode: String, callback: @escaping (Bool) -> Void) {
        self.status.value = .loading(currencyCode == "" ? "Fetching needed data" : "Calculating...")
        
//        self.status.value = .view
        callback(true)
    }
    
    func calculateConversions() {
        
    }
}
