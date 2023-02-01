//
//  CurrencyAndRates.swift
//  MVVM_TransactionsConversor
//
//  Created by Oriol Roig Albert on 1/2/23.
//

import Foundation

enum Currency : String {
    
    case AUD = "AUD"; case INR = "INR"; case TRY = "TRY"
    case BGN = "BGN"; case ISK = "ISK"; case USD = "USD"
    case BRL = "BRL"; case JPY = "JPY"; case ZAR = "ZAR"
    case CAD = "CAD"; case KRW = "KRW"
    case CHF = "CHF"; case MXN = "MXN"
    case CNY = "CNY"; case MYR = "MYR"
    case CZK = "CZK"; case NOK = "NOK"
    case DKK = "DKK"; case NZD = "NZD"
    case EUR = "EUR"; case PHP = "PHP"
    case GBP = "GBP"; case PLN = "PLN"
    case HKD = "HKD"; case RON = "RON"
    case HRK = "HRK"; case RUB = "RUB"
    case HUF = "HUF"; case SEK = "SEK"
    case IDR = "IDR"; case SGD = "SGD"
    case ILS = "ILS"; case THB = "THB"
    
}

struct Rate: Decodable {
    let from: String?
    let to: String?
    let rate: Double?
}

struct RatesModel: Decodable {
    var rates: [Rate]
    init(rates: [Rate]) {
        self.rates = rates
    }
}

