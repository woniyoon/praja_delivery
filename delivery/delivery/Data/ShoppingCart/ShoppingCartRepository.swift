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
    func deleteShoppingCart()
    func addProductShoppingCart(shoppingCart: ShoppingCartEntity)
    func fetchShoppingCart() -> Single<[ProductShoppingCartEntity]>
    func deleteProductFromShoppingCart(with primaryKey: String)
}

class ShoppingCartRepository: ShoppingCartRepositoryProtocol {
    private let dataStore: ShoppingCartDataStoreProtocol
    
    init(dataStore: ShoppingCartDataStoreProtocol) {
        self.dataStore = dataStore
    }
        
    func addProductShoppingCart(shoppingCart: ShoppingCartEntity) {
        dataStore.addProductShoppingCart(shoppingCart: shoppingCart)
    }
    
    func fetchShoppingCart() -> Single<[ProductShoppingCartEntity]> {
        return dataStore.fetchShoppingCart()
    }
    
    func deleteShoppingCart() {
        dataStore.deleteShoppingCart()
    }
    
    func deleteProductFromShoppingCart(with primaryKey: String){
        dataStore.deleteProductFromShoppingCart(with: primaryKey)
    }
    
    
}
