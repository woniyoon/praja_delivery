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

class ProductCellModel {
    
    static var Identifier = "ProductCellModel"
    
    private var useCase: ProductListUseCaseProtocol
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var oldPrice: UILabel!
    
    private(set) lazy var products : Single<[Product]> =
        self.useCase.fetchProductList()
            .observeOn(MainScheduler.instance)
    
    init(useCase: ProductListUseCaseProtocol) {
        self.useCase = useCase
    }
    
    var product: Product? {
        didSet {
            guard let product = product else { return }
            self.name.text = product.name
            self.price.text = String(format:"%.2f", product.price)
            self.oldPrice.text = String(format:"%.2f", product.originalPrice)
        }
    }
}

