//
//  ProductDetailUseCase.swift
//  delivery
//
//  Created by Kento Uchida on 2018/02/24.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

protocol ProductDetailUseCaseProtocol {
    func fetchProductDetail(_ id: String, error err: (Error) -> Void, callback: @escaping (SampleProductModel) -> Void)
}

class ProductDetailUseCase: ProductDetailUseCaseProtocol {
    
    internal let repository: ProductDetailRepositoryProtocol
    internal let translator: ProductDetailTranslator
    
    init(repository: ProductDetailRepositoryProtocol, translator: ProductDetailTranslator) {
        self.repository = repository
        self.translator = translator
    }
    
    func fetchProductDetail(_ id: String, error err: (Error) -> Void, callback: @escaping (SampleProductModel) -> Void) {
        repository.fetchProductDetail(id, err) { entity in
            let model = self.translator.translate(entity)
            callback(model)
        }
    }
}
