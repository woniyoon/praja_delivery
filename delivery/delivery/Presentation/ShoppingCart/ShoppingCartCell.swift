//
//  ShoppingCartCell.swift
//  delivery
//
//  Created by Bacelar on 2018-04-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import UIKit
import Kingfisher

class ShoppingCartCell: UICollectionViewCell {
    
    static var Identifier = "ShoppingCartCell"
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var oldPrice: BaseLabel!
    @IBOutlet weak var percentage: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        productImage.image = nil
    }
    
    var shoppingCart: ShoppingCart? {
        didSet {
            guard let shoppingCart = shoppingCart else { return }
            self.name.text = shoppingCart.
            self.price.text = String(format:"%.2f", product.price)
            self.oldPrice.text = String(format:"%.2f", product.originalPrice)
            self.percentage.text = ("\(product.discountPercent) %")
            
            let imageUrlString = product.images[0]
            let imageUrl:URL = URL(string: imageUrlString)!
            
            let resource = ImageResource(downloadURL: imageUrl, cacheKey: product.name)
            self.productImage.kf.setImage(with: resource)
            
        }
        
    }
}

