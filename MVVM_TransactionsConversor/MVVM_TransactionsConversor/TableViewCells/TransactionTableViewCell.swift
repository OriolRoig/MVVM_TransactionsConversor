//
//  TransactionTableViewCell.swift
//  MVVM_TransactionsConversor
//
//  Created by Oriol Roig Albert on 1/2/23.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var transactionSkuLabel: UILabel!
    @IBOutlet weak var transactionAmountLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
    var transaction : TransactionData? {
        
        didSet {
            transactionSkuLabel.text = transaction?.sku
            transactionAmountLabel.text = "\(String(describing: transaction?.roundedAmount))"
            currencyLabel.text = transaction?.currency
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
