//
//  ProductDetailUseCase.swift
//  delivery
//
//  Created by Kento Uchida on 2018/02/24.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

protocol ProductDetailUseCaseProtocol {
    func fetchProductDetail(_ id: String, callback: (ProductDetailModel, Error) -> Void)
}

class ProductDetailUseCase: ProductDetailUseCaseProtocol {
    
    internal let repository: ProductDetailRepositoryProtocol
    internal let translator: ProductDetailTranslator
    
    init(repository: ProductDetailRepositoryProtocol, translator: ProductDetailTranslator) {
        self.repository = repository
        self.translator = translator
    }
    
    func fetchProductDetail(_ id: String, callback: (ProductDetailModel, Error) -> Void) {
        repository.fetchProductDetail(id) { (entity, error) in
            let model = translator.translate(entity)
            callback(model, error)
        }
    }
}
