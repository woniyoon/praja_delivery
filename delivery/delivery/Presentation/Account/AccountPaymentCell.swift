//
//  AccountPaymentCell.swift
//  delivery
//
//  Created by Diego H. Vanni on 2018-03-27.
//  Copyright © 2018 CICCC. All rights reserved.
//

import UIKit

class AccountPaymentCell: UITableViewCell {
    static var Identifier = "AccountPaymentCell"
    
    @IBOutlet weak var cardHolderLabel: UILabel!
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var cardExpireDateLabel: UILabel!
    
    var payment: Payment? {
        didSet {
            guard let payment = payment else { return }
            cardHolderLabel.text = payment.holderName
            cardNumberLabel.text = payment.cardNumber
            cardExpireDateLabel.text = payment.expiryDate
        }
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

