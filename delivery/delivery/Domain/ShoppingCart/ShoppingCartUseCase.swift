//
//  ShoppingCartUseCase.swift
//  delivery
//
//  Created by Bacelar on 2018-04-05.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift

protocol ShoppingCartUseCaseProtocol {
    func deleteShoppingCart()
    func addProductShoppingCart(shoppingCart: ShoppingCart)
    func updateProductShoppingCart(shoppingCart: ShoppingCart)
    func fetchShoppingCart() -> Single<[ProductShoppingCart]>
    func deleteProductFromShoppingCart(with primaryKey: String)
    func productAlreadyInCart(with primaryKey: String) -> Bool
}

class ShoppingCartUseCase: ShoppingCartUseCaseProtocol {
    
    internal let repository: ShoppingCartRepositoryProtocol
    internal let translator: ShoppingCartTranslator
    
    init(repository: ShoppingCartRepositoryProtocol, translator: ShoppingCartTranslator) {
        self.repository = repository
        self.translator = translator
    }
    
    func deleteShoppingCart() {
        repository.deleteShoppingCart()
    }
    
    func addProductShoppingCart(shoppingCart: ShoppingCart) {
    
        let shoppingCartEntity = translator.translate(shoppingCart)
        repository.addProductShoppingCart(shoppingCart: shoppingCartEntity)
    }
    
    func updateProductShoppingCart(shoppingCart: ShoppingCart) {
        
        let shoppingCartEntity = translator.translate(shoppingCart)
        repository.updateProductShoppingCart(shoppingCart: shoppingCartEntity)
    }
    
    func fetchShoppingCart() -> Single<[ProductShoppingCart]> {
        return repository.fetchShoppingCart().map { (shoppingCartEntity) -> [ProductShoppingCart] in
            self.translator.translateShoppingCart(shoppingCartEntity)
        }
    }
    
    func deleteProductFromShoppingCart(with primaryKey: String){
        repository.deleteProductFromShoppingCart(with: primaryKey)
    }
    
    func productAlreadyInCart(with primaryKey: String) -> Bool {
        return repository.productAlreadyInCart(with: primaryKey)
    }
    
}
