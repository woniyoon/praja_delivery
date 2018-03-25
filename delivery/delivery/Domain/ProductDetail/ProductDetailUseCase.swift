//
//  ProductDetailUseCase.swift
//  delivery
//
//  Created by Kento Uchida on 2018/02/24.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift

protocol ProductDetailUseCaseProtocol {
    func fetchProductDetail(_ id: String) -> Single<Product>
}

class ProductDetailUseCase: ProductDetailUseCaseProtocol {
    
    internal let repository: ProductDetailRepositoryProtocol
    internal let translator: ProductDetailTranslator
    
    init(repository: ProductDetailRepositoryProtocol, translator: ProductDetailTranslator) {
        self.repository = repository
        self.translator = translator
    }

    func fetchProductDetail(_ id: String) -> Single<Product> {
        return repository.fetchProductDetail(id)
            .map({ entity in
                self.translator.translate(entity)
            })
    }
}
