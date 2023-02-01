//
//  CurrencyConverter.swift
//  MVVM_TransactionsConversor
//
//  Created by Oriol Roig Albert on 1/2/23.
//

import Foundation

//toDO change strings to enum
class CurrencyConverter : NSObject {
    
    private var apiService : APIService
    private var ratesData : RatesModel!
    
    override init() {
        self.apiService = APIService()
        super.init()
        callFuncToGetRates()
    }
    
    func callFuncToGetRates() {
        apiService.apiToGetRatesData { (ratesData) in
            self.ratesData = RatesModel.init(rates: ratesData)
        }
    }
    
    public func convert(_ value : Double, valueCurrency : String, outputCurrency : String) -> Double {
        let value = value * (searchRate(valueCurrency: valueCurrency, outputCurrency: outputCurrency))
        
        return value
    }
    
    public func searchRate(valueCurrency : String, outputCurrency : String) ->  Double {
        if valueCurrency == outputCurrency {
            return 1
        }
        
        var currentCurrencyOptions = [String] ()
        var outPutCurrencyOptions = [String] ()

        for rate in ratesData.rates {
            if (rate.from == valueCurrency && rate.to == outputCurrency) {
                if let rateResult = rate.rate {
                    return rateResult
                }
            }
            if rate.from == valueCurrency {
                if let rateToResult = rate.to {
                    currentCurrencyOptions.append(rateToResult)
                }
            }
            if rate.to == outputCurrency {
                if let rateFromResult = rate.from {
                    outPutCurrencyOptions.append(rateFromResult)
                }
            }
        }
        
        var totalRate: Double = 1
        for changeOption in currentCurrencyOptions {
            if changeOption != "" {
                for rate in ratesData.rates {
                    if let rateResult = rate.rate {
                        if rate.from == valueCurrency && rate.to == changeOption {
                            totalRate = totalRate * (rateResult)
                        }
                        if rate.from == changeOption && rate.to == outputCurrency {
                            totalRate = (totalRate * (rateResult))
                        }
                    }
                }
                if outPutCurrencyOptions.contains(changeOption) {
                    return totalRate
                } else {
                    totalRate = totalRate * searchRate(valueCurrency: changeOption, outputCurrency: outputCurrency)
                }
                return totalRate
            }
        }
        return totalRate
    }

    public static func round(value: Double) -> Double{
        return (value * 100).rounded() / 100
    }
}
