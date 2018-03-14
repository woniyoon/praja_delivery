//
//  HomeUseCase.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-03-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

protocol HomeUseCaseProtocol {
    func fetchProducts() -> ProductModel
}

class HomeUseCase: HomeUseCaseProtocol {
    
    internal let repository: HomeRepositoryProtocol
    internal let translator: HomeTranslator

    init(repository: HomeRepositoryProtocol, translator: HomeTranslator) {
        self.repository = repository
        self.translator = translator
    }

    func fetchProducts() -> ProductModel {
        let result = repository.fetchProducts()
        
        return translator.translate(result)
    }
}
