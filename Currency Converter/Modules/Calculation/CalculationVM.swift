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
    case error(String, Bool, String)
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
    
    init() {
        // TODO: Get existing currencies codes. If not fetch
    }
    
    func fetchData(initialFetch: Bool, callback: @escaping (Bool) -> Void) {
        self.status.value = .loading(initialFetch ? "Fetching needed data" : "Calculating...")
        
        self.status.value = .view
        
        callback(true)
    }
    
    func calculateConversions() {
        
    }
}
