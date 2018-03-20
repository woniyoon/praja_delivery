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
    func fetchProductList() -> [SampleProductModel]
    func fetchProductCount() -> Int
    func fetchProduct(product: SampleProductModel) -> SampleProductModel
}

class ProductListUseCase: ProductListUseCaseProtocol {
    
    internal let repository: ProductListRepositoryProtocol
    internal let translator: ProductListTranslator
    
    init(repository: ProductListRepositoryProtocol, translator: ProductListTranslator) {
        self.repository = repository
        self.translator = translator
    }
    
    func fetchProductList() -> [SampleProductModel] {
        
        let entity = repository.fetchProductList()
        var productList = [SampleProductModel]()
        
        entity.forEach { product in
            let product = SampleProductModel(id: product.id, name: product.name, price: product.price, originalPrice: product.originalPrice, description: product.description)
            
                productList.append(product)
        }
        
        return productList
    }
    
    func fetchProductCount() -> Int {
        return fetchProductList().count
    }
    
    func fetchProduct(product: SampleProductModel) -> SampleProductModel {
        return product
    }
    
}
