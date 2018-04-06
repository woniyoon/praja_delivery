//
//  ShoppingCartTranslator.swift
//  delivery
//
//  Created by Bacelar on 2018-04-05.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

class ShoppingCartTranslator: TranslatorProtocol {
    func translate(_ shoppingCart: ShoppingCart) -> ShoppingCartEntity {
    
        let shopping = ShoppingCartEntity()
        shopping.quantity = shoppingCart.quantity
        
        for (_, product) in shoppingCart.idProducts.enumerated() {
            shopping.idProducts.append(product)
        }
        
        return shopping
    }
}
