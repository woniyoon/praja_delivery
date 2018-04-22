//
//  AddressListCell.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-04-20.
//  Copyright © 2018 CICCC. All rights reserved.
//

import UIKit

class AddressListCell: UITableViewCell {

    @IBOutlet weak var radioButton: UIImageView!
    @IBOutlet weak var editButton: UIImageView!
    @IBOutlet weak var deleteButton: UIImageView!

    @IBOutlet weak var receiverLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var zipCodeLabel: UILabel!
    
    
    static var Identifier: String = "AddressListCell"

    
    var item: Address? {
        didSet {
            guard let item = item else { return }
            receiverLabel.text = item.receiver
            addressLabel.text = "\(item.address1) \(item.address2)"
            zipCodeLabel.text = item.postalCode
            
            if item.isDefault {
                radioButton.image = #imageLiteral(resourceName: "radio_on")
            } else {
                radioButton.image = #imageLiteral(resourceName: "radio_off")
            }
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
