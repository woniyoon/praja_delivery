//
//  AccountShippingCell.swift
//  delivery
//
//  Created by Diego H. Vanni on 2018-03-27.
//  Copyright © 2018 CICCC. All rights reserved.
//

import UIKit

class AccountShippingCell: UITableViewCell {
    static var Identifier = "AccountShippingCell"
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var fullAddressLabel: UILabel!
    @IBOutlet weak var postalCodeLabel: UILabel!
    
    var address: Address? {
        didSet {
            guard let address = address else { return }
            //shippingImageView.image = UIImage(named: "\(account.shipping)")
            //editShippingImageView.image = UIImage(named: "\(account.edit)")
            fullNameLabel.text = address.receiver
            fullAddressLabel.text = "\(address.address1), \(address.address2), \(address.city), \(address.province), \(address.country)"
            postalCodeLabel.text = address.postalCode
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
