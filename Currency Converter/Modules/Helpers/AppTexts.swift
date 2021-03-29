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
    
    var rawValue: String {
        switch self {
        case .appName:
            if let bundleDisplayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String {
                return bundleDisplayName
            } else if let bundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String {
                return bundleName
            } else { return "App Name" }
        case .appAuthor: return "Aarón Granado Amores. 27/03/2021."
        case .appDescription: return "Conversor de divisas realizado como prueba técnica para el proceso de selección de Indra."
        case .inputPlaceholder: return "Introduca cantidad"
        case .calculateButton: return "Calcular"
        case .alertTitle: return "Info"
        case .alertMessage: return "Debe introducir una cantidad para convertir"
        case .okButton: return "Aceptar"
        case .cancelButton: return "Cancelar"
        }
    }
}
