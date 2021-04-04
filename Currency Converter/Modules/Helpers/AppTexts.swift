//
//  AppTexts.swift
//  Currency Converter
//
//  Created by Aaron Granado Amores on 27/03/2021.
//

import UIKit

// swiftlint:disable line_length
enum AppText {
    case appName
    case appAuthor
    case appDescription
    case inputPlaceholder
    case calculateButton
    case alertTitle
    case alertMessage
    case okButton
    case cancelButton
    case reloadButton
    case fetchingCurrencies
    case fetchingConversions
    case errorFetching
    
    var rawValue: String {
        switch self {
        case .appName:
            if let bundleDisplayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String {
                return bundleDisplayName
            } else if let bundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String {
                return bundleName
            } else { return "App Name" }
        case .appAuthor: return "Aarón Granado Amores."
        case .appDescription: return "Conversor de divisas realizado como prueba técnica para el proceso de selección de Indra."
        case .inputPlaceholder: return "Introduca cantidad"
        case .calculateButton: return "Calcular"
        case .alertTitle: return "Info"
        case .alertMessage: return "La cantidad está vacía o la divisa no es válida"
        case .okButton: return "Aceptar"
        case .cancelButton: return "Cancelar"
        case .reloadButton: return "Reintentar"
        case .fetchingCurrencies: return "Obteniendo divisas disponibles"
        case .fetchingConversions: return "Obteniendo tasas de cambio para %@"
        case .errorFetching: return "Error al obtener las divisas o las tasas de cambio"
        }
    }
}
