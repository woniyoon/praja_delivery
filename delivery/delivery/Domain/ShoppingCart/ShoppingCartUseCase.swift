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
    func addProductShoppingCart(shoppingCart: ShoppingCart)
    func fetchShoppingCart() -> Single<[ProductShoppingCart]>
}

class ShoppingCartUseCase: ShoppingCartUseCaseProtocol {
    
    internal let repository: ShoppingCartRepositoryProtocol
    internal let translator: ShoppingCartTranslator
    
    init(repository: ShoppingCartRepositoryProtocol, translator: ShoppingCartTranslator) {
        self.repository = repository
        self.translator = translator
    }
    
    func addProductShoppingCart(shoppingCart: ShoppingCart) {
    
        let shoppingCartEntity = translator.translate(shoppingCart)
        repository.addProductShoppingCart(shoppingCart: shoppingCartEntity)
    }
    
    func fetchShoppingCart() -> Single<[ProductShoppingCart]> {
        return repository.fetchShoppingCart().map { (shoppingCartEntity) -> [ProductShoppingCart] in
            self.translator.translateShoppingCart(shoppingCartEntity)
        }
    }
    
    
}
