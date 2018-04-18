//
//  AccountPaymentCell.swift
//  delivery
//
//  Created by Diego H. Vanni on 2018-03-27.
//  Copyright © 2018 CICCC. All rights reserved.
//

import UIKit
import Kingfisher

class AccountPaymentCell: UICollectionViewCell, UICollectionViewDelegate {
    static var Identifier = "Payment"
    
    @IBOutlet weak var cardHolderLabel: UILabel!
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var cardExpiryDateLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    var payment: Payment? {
        didSet {
            
            var date = Date()
            date = (payment?.expiryDate)!
            
            guard let payment = payment else { return }
            cardHolderLabel.text = payment.holderName
            cardNumberLabel.text = payment.cardNumber
            cardExpiryDateLabel.text = date.toString(dateFormat: "MM/yy")
        }
    }
}

