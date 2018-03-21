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
    
    static var Identifier = "ProductCellModel"
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var oldPrice: UILabel!

    var sampleProductModel: SampleProductModel? {
        didSet {
            guard let sampleProductModel = sampleProductModel else { return }
            name.text = sampleProductModel.name
            price.text = String(format:"%.2f", sampleProductModel.price)
            oldPrice.text = String(format:"%.2f", sampleProductModel.originalPrice)

            }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

