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
    
    var date = Date()
    
    var payment: Payment? {
        didSet {
            guard let payment = payment else { return }
            //paymentImageView.image = UIImage(named: "\(payment.payment)")
            //editPaymentImageView.image = UIImage(named: "\(payment.payment)")
            cardHolderLabel.text = payment.holderName
            cardNumberLabel.text = payment.cardNumber
            date = payment.expiryDate
            cardExpireDateLabel.text = date.toString(dateFormat: "MM-dd-yyyy")
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

//Date Conversion to String
extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}

