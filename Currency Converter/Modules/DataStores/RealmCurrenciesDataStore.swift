//
//  RealmDataStore.swift
//  Currency Converter
//
//  Created by Aaron Granado Amores on 05/04/2021.
//

import RealmSwift

class RealmCurrenciesDataStore: BaseRealmDataStore {
    typealias ObjectType = RCurrencies
    
    static let shared = RealmCurrenciesDataStore()
    
    func addCurrencies(appModel: Currencies) {
        self.deleteCurrencies()
        self.create(object: RCurrencies.init(appModel: appModel))
    }
    
    func getCurrencies() -> Currencies? {
        guard let existing = Array(self.getAll()).first else { return nil }
        return Currencies.init(realmModel: existing)
    }
    
    func deleteCurrencies() {
        let currenciesToDelete = self.getAll()
        self.delete(objects: Array(currenciesToDelete))
    }
}
