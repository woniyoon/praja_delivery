//
//  UserInfoCell.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-04-04.
//  Copyright © 2018 CICCC. All rights reserved.
//

import UIKit

class UserInfoCell: UITableViewCell {

    static var Identifier: String = "UserInfoCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mobileNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var item: User? {
        didSet {
            guard let item = item else { return }
            nameLabel.text = "\(item.firstName) \(item.lastName)"
            mobileNumberLabel.text = item.mobileNumber
            emailLabel.text = item.email
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
