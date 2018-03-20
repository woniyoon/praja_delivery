//
//  ProductListModel.swift
//  delivery
//
//  Created by Bacelar on 2018-03-19.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class ProductCellModel: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var oldPrice: UILabel!

    func updateViews(product: SampleProductModel) {

        name.text = product.name
        price.text = String(format:"%.2f", product.price)
        oldPrice.text = String(format:"%.2f", product.originalPrice)

    }
    
    
}
