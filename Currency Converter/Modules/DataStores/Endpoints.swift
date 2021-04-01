//
//  Endpoints.swift
//  Currency Converter
//
//  Created by Aaron Granado Amores on 01/04/2021.
//

import Foundation

enum Endpoints: String {
    case standardConversions = "https://api.exchangerate.host/latest"
    case givenCurrency = "https://api.exchangerate.host/latest?base="
}
