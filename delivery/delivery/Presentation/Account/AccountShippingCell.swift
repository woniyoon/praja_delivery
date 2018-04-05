//
//  AccountShippingCell.swift
//  delivery
//
//  Created by Diego H. Vanni on 2018-03-27.
//  Copyright © 2018 CICCC. All rights reserved.
//

import UIKit
import Kingfisher

class AccountShippingCell: UICollectionViewCell {
    static var Identifier = "Shipping"
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var fullAddressLabel: UILabel!
    @IBOutlet weak var postalCodeLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    var address: AddressEntity? {
        didSet {
            guard let address = address else { return }
            fullNameLabel.text = address.receiver
            fullAddressLabel.text = ("\(address.address1), \(address.address2), \(address.city), \(address.province), \(address.country)")
            postalCodeLabel.text = address.postalCode
        }
    }
    
}
