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
    
    @IBOutlet weak var deleteProduct: UIButton!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var oldPrice: BaseLabel!
    @IBOutlet weak var percentage: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        productImage.image = nil
    }
    
//    let deleteButton: UIButton = {
//
//        let button = UIButton(type: UIButtonType.system)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        button.alpha = 1
//        button.isHidden = true
//        return button
//    }()
    
    func setupViews(){
        
        // add a button
//        addSubview(deleteButton)
        
//        let deleteButton = UIButton(frame: CGRect(x: cell.bounds.maxX - 100, y:0, width:50,height:50))
//        deleteButton.frame = .init(x: self.frame.maxX - 50, y: 0, width: 50, height: 50)
//        deleteButton.autoresizingMask = [.flexibleLeftMargin, .flexibleBottomMargin]
//        deleteButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
//        deleteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        // add the touchUpInside target
//        deleteButton.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
    }
    
    var productShoppingCart: ProductShoppingCart? {
        didSet {
            guard let shoppingCart = productShoppingCart else { return }
            self.name.text = shoppingCart.product.name
            self.price.text = String(format:"%.2f", shoppingCart.product.price)
            self.oldPrice.text = String(format:"%.2f", shoppingCart.product.originalPrice)
            self.percentage.text = ("\(shoppingCart.product.discountPercent) %")
            
            let imageUrlString = shoppingCart.product.images[0]
            let imageUrl:URL = URL(string: imageUrlString)!
            
            let resource = ImageResource(downloadURL: imageUrl, cacheKey: shoppingCart.product.name)
            self.productImage.kf.setImage(with: resource)
        }
    }
}

