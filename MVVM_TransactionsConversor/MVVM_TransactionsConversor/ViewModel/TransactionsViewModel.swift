//
//  TransactionsViewModel.swift
//  MVVM_TransactionsConversor
//
//  Created by Oriol Roig Albert on 1/2/23.
//

import Foundation

class TransactionsViewModel : NSObject {
   
    private let defaultRate = "EUR"
    
    private var apiService : APIService!
    private var currencyConverter: CurrencyConverter!
    private(set) var transactions : TransactionsModel! {
        didSet {
            self.bindTransactionsViewModelToController()
        }
    }
    
    var bindTransactionsViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService =  APIService()
        self.currencyConverter = CurrencyConverter()
        self.callFuncToGetTransactions()
    }
    
    internal func configureTransactionsModel(){
        setMainCurrency(newCurrency: defaultRate)
        groupTransactionData()
    }
    
    internal func callFuncToGetTransactions() {
        self.apiService.apiToGetTransactionsData { (transactionData) in
            self.transactions = TransactionsModel.init(transactionData: transactionData, currency: self.defaultRate)
            self.configureTransactionsModel()
        }
    }
    
    func setMainCurrency(newCurrency: String){
        transactions.currency = newCurrency
    }
    
    public func changeCellTransactionCurrency(transaction: TransactionData, index: Int) {
        transactions.transactionData[index] = changeTransactionCurrency(transaction: transaction)
    }
    
 
    internal func changeTransactionCurrency(transaction: TransactionData) -> TransactionData {
        var newTransaction: TransactionData = transaction
        if transactions.currency != nil && transaction.currency != transactions.currency {
            if let transactionAmount =  transaction.amount{
                if let transactionCurrency = transaction.currency{
                    newTransaction.amount = currencyConverter.convert( transactionAmount, valueCurrency: transactionCurrency, outputCurrency: transactions.currency ?? defaultRate)
                    if let newTransactionAmount = newTransaction.amount{
                        newTransaction.roundedAmount = CurrencyConverter.round(value: newTransactionAmount)
                    }
                    newTransaction.currency = transactions.currency
                }
            }
        }
        return newTransaction
    }

    internal func groupTransactionData() {
        var groupedTransaction: [TransactionData]?
        
        for transaction in transactions!.transactionData {
            var newTransaction: TransactionData
            
            if groupedTransaction == nil {
                if transaction.currency == transactions.currency {
                    newTransaction = transaction
                    if let newTransactionAmount = newTransaction.amount{
                        newTransaction.roundedAmount = CurrencyConverter.round(value: newTransactionAmount)
                    }
                    groupedTransaction = [transaction]
                } else {
                    groupedTransaction = [changeTransactionCurrency(transaction: transaction)]
                }
            } else if let row = groupedTransaction?.firstIndex(where: {$0.sku == transaction.sku}) {
                newTransaction = changeTransactionCurrency(transaction: transaction)
                if var newTransactionAmount = newTransaction.amount {
                    if let groupedTransactionAmount = groupedTransaction?[row].amount {
                        newTransactionAmount = newTransactionAmount + groupedTransactionAmount
                        newTransaction.amount = newTransactionAmount
                        newTransaction.roundedAmount = CurrencyConverter.round(value: newTransactionAmount )
                    }
                }
                groupedTransaction?[row] = newTransaction
            } else {
                groupedTransaction?.append(changeTransactionCurrency(transaction: transaction))
            }
        }
        self.transactions = TransactionsModel.init(transactionData: groupedTransaction ?? self.transactions.transactionData, currency: self.transactions.currency)
        
    }

}
