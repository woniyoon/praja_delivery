//
//  ProductListTranslator.swift
//  delivery
//
//  Created by Bacelar on 2018-03-13.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

class ProductListTranslator: TranslatorProtocol {
    func translate(_ entity: [ProductEntity]) -> [ProductDetailModel] {
        
        var productList = [ProductDetailModel]()
        
        entity.forEach { product in
            let product = ProductDetailModel(name: product.name, price: product.price, originalPrice: product.originalPrice, images: product.images)
            
            productList.append(product)
        }
    
        return productList
    }
}
