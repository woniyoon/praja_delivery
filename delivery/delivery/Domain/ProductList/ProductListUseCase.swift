//
//  ProductListUseCase.swift
//  delivery
//
//  Created by Bacelar on 2018-03-13.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift


protocol ProductListUseCaseProtocol {
    func fetchProductList(with keyword: String) -> Single<[Product]>
    func fetchProductList2() -> [Product]
    func fetchProduct(product: Product) -> Product
}

class ProductListUseCase: ProductListUseCaseProtocol {
    
    internal let repository: ProductListRepositoryProtocol
    internal let translator: ProductListTranslator
    
    init(repository: ProductListRepositoryProtocol, translator: ProductListTranslator) {
        self.repository = repository
        self.translator = translator
    }
    
    func fetchProductList2() -> [Product] {
        
        let products = repository.fetchProductList2()
        return translator.translate(products)
    }
    
    func fetchProductList(with keyword: String) -> Single<[Product]> {
        return repository.fetchProductList(with: keyword).map { (entities) -> [Product] in
            self.translator.translate(entities)
        }        
    }
    
    func fetchProduct(product: Product) -> Product {
        return product
    }
}
