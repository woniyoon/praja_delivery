//
//  ProductImageCell.swift
//  delivery
//
//  Created by Kento Uchida on 2018/03/30.
//  Copyright © 2018 CICCC. All rights reserved.
//

import UIKit

class ProductImageCell: UICollectionViewCell {
    static var Identifier = "ProductImageCell"

    @IBOutlet weak var imageView: UIImageView!
    
    var imageUrl: String? {
        didSet {
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
