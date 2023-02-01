//
//  ViewController.swift
//  MVVM_TransactionsConversor
//
//  Created by Oriol Roig Albert on 1/2/23.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var transactionTableView: UITableView!
    
    private var transactionViewModel : TransactionsViewModel!
    
    private var dataSource : TransactionsTableViewDataSource<TransactionTableViewCell,TransactionData>!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        registerTransactionCell()
        callToViewModelForUIUpdate()
        
    }
    
    func registerTransactionCell() {
        let nib = UINib(nibName: "TransactionTableViewCell", bundle: nil)
        transactionTableView.register(nib, forCellReuseIdentifier: "TransactionTableViewCell")
    }
    
    func callToViewModelForUIUpdate(){
        
        self.transactionViewModel =  TransactionsViewModel()
       
        self.transactionViewModel.bindTransactionsViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource(){
        DispatchQueue.main.async {
        self.dataSource = TransactionsTableViewDataSource(cellIdentifier: "TransactionTableViewCell", items: self.transactionViewModel.transactions.transactionData, configureCell: { (cell, trans) in
            
            cell.transactionSkuLabel.text = trans.sku
            cell.currencyLabel.text = trans.currency
            if let roundedAmount = trans.roundedAmount {
                cell.transactionAmountLabel.text = "\(String(describing: roundedAmount))"
            }
        })
        
        
            self.transactionTableView.dataSource = self.dataSource
            self.transactionTableView.delegate = self.dataSource
            self.transactionTableView.reloadData()
        }
    }
    
}




