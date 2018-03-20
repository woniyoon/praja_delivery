//
//  ProductListTranslator.swift
//  delivery
//
//  Created by Bacelar on 2018-03-13.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

class ProductListTranslator: TranslatorProtocol {
    func translate(_ entity: [SampleProductEntity]) -> [SampleProductModel] {
        
        var productList = [SampleProductModel]()
        
        entity.forEach { product in
            let product = SampleProductModel(id: product.id, name: product.name, price: product.price, originalPrice: product.originalPrice, description: product.description)
            
            productList.append(product)
        }
        
        return productList
    }
}
