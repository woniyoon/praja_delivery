//
//  PaymentCell.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-04-17.
//  Copyright © 2018 CICCC. All rights reserved.
//

import UIKit

class PaymentCell: UITableViewCell {
    
    static var Identifier: String = "PaymentCell"

    @IBOutlet weak var cardHolder: UILabel!
    @IBOutlet weak var cardNumber: UILabel!
    @IBOutlet weak var expiryDate: UILabel!

    
//    var items: [Payment]? {
//        didSet {
//            guard let items = items else { return }
//            items.forEach { (payment) in
//                cardHolder.text = payment.holderName
//                cardNumber.text = payment.cardNumber
//                expiryDate.text = payment.expiryDate.description
//            }
//        }
//    }
//

    var item: Payment? {
        didSet {
            guard let item = item else { return }
            cardHolder.text = item.holderName
            //            let test = item.address.filter { $0.isDefault}
            //            addressLabel.text = "\(test.first!.address1) \(test.first!.address2)"
            //            zipCodeLabel.text = "\(test.first!.postalCode)"
            cardNumber.text = item.cardNumber
            expiryDate.text = item.expiryDate.description
            
            
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
