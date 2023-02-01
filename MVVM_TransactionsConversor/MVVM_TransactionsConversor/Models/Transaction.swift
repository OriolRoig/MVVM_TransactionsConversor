//
//  Transaction.swift
//  MVVM_TransactionsConversor
//
//  Created by Oriol Roig Albert on 1/2/23.
//

import Foundation


struct TransactionsModel: Decodable {
    var transactionData: [TransactionData]
    var currency: String?
    
    init(transactionData: [TransactionData], currency: String? = nil) {
        self.transactionData = transactionData
        self.currency = currency
    }
}

struct TransactionData: Decodable {
    let sku: String?
    var amount: Double?
    var currency: String?
    var roundedAmount: Double?
}
