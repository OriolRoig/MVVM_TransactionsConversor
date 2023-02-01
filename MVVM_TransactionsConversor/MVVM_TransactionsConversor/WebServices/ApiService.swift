//
//  ApiService.swift
//  MVVM_TransactionsConversor
//
//  Created by Oriol Roig Albert on 1/2/23.
//

import Foundation


class APIService : NSObject {
    
    private let ratesUrl = "https://android-ios-service.herokuapp.com/rates"
    private let transactionsUrl = "https://android-ios-service.herokuapp.com/transactions"

    func apiToGetRatesData(completion : @escaping ([Rate]) -> ()) {
        guard let url = URL(string: ratesUrl) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) {
            data, response, error in
            let decoder = JSONDecoder()
            if let data = data {
                do {
                    let ratesData = try decoder.decode([Rate].self, from: data)
                    completion(ratesData)
                } catch {
                    print("ApiError : \(error)")
                }
            }
        }.resume()
    }
    
    func apiToGetTransactionsData(completion : @escaping ([TransactionData]) -> ()) {
        guard let url = URL(string: transactionsUrl) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) {
            data, response, error in
            let decoder = JSONDecoder()
            if let data = data {
                do {
                    let transactionsData = try decoder.decode([TransactionData].self, from: data)
                    completion(transactionsData)
                } catch {
                    print("ApiError : \(error)")
                }
            }
        }.resume()
    }
}
