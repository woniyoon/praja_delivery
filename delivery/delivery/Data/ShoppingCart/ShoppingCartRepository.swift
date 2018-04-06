//
//  ShoppingCartRepository.swift
//  delivery
//
//  Created by Bacelar on 2018-04-05.
//  Copyright © 2018 CICCC. All rights reserved.
//
import Foundation
import RxSwift

protocol ShoppingCartRepositoryProtocol{
//    func fetchShoppingCart() -> [ProductEntity]
    func addProductShoppingCart(shoppingCart: ShoppingCartEntity)
}

class ShoppingCartRepository: ShoppingCartRepositoryProtocol {
    
    private let dataStore: ShoppingCartDataStoreProtocol
    
    init(dataStore: ShoppingCartDataStoreProtocol) {
        self.dataStore = dataStore
    }
    
//    func fetchShoppingCart() -> [ProductEntity] {
//        dataStore.fetchShoppingCart()
//    }
    
    func addProductShoppingCart(shoppingCart: ShoppingCartEntity) {
        dataStore.addProductShoppingCart(shoppingCart: shoppingCart)
    }
    
}
