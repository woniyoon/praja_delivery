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
        
        return translator.translate(entity)
        
    }
    
    func fetchProduct(product: SampleProductModel) -> SampleProductModel {
        return product
    }
}
