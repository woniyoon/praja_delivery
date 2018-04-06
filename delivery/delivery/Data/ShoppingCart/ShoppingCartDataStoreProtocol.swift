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
//    func fetchShoppingCart() -> [ProductEntity]
    func addProductShoppingCart(shoppingCart: ShoppingCartEntity)
}
