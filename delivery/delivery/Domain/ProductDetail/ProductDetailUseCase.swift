//
//  ProductDetailUseCase.swift
//  delivery
//
//  Created by Kento Uchida on 2018/02/24.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

protocol ProductDetailUseCaseProtocol {
    func fetchProductDetail(_ id: String) -> ProductDetailModel
}

class ProductDetailUseCase {
    
    internal let repository: ProductDetailRepositoryProtocol
    internal let translator: ProductDetailTranslator
    
    init(repository: ProductDetailRepositoryProtocol, translator: ProductDetailTranslator) {
        self.repository = repository
        self.translator = translator
    }
}

extension ProductDetailUseCase: ProductDetailUseCaseProtocol {
    func fetchProductDetail(_ id: String) -> ProductDetailModel {
        let entity = repository.fetchProductDetail(id)
        return translator.translate(entity)
    }
}
