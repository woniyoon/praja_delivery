//
//  ShoppingCartDataStoreProtocol.swift
//  delivery
//
//  Created by Bacelar on 2018-04-05.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift

protocol ShoppingCartDataStoreProtocol {
    func addProductShoppingCart(shoppingCart: ShoppingCartEntity)
    func updateProductShoppingCart(shoppingCart: ShoppingCartEntity)
    func fetchShoppingCart() -> Single<[ProductShoppingCartEntity]>
    func deleteShoppingCart()
    func deleteProductFromShoppingCart(with primaryKey: String)
    func productAlreadyInCart(with primaryKey: String) -> Bool
    
}
