//
//  HomeUseCase.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-03-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift

protocol HomeUseCaseProtocol {
    func fetchTopSales() -> Single<[Product]>
    func fetchProductYouMayLike() -> Single<[Product]>
    func fetchNewProducts() -> Single<[Product]>

}

class HomeUseCase: HomeUseCaseProtocol {    
    
    internal let repository: HomeRepositoryProtocol
    internal let translator: HomeTranslator

    init(repository: HomeRepositoryProtocol, translator: HomeTranslator) {
        self.repository = repository
        self.translator = translator
    }
    
    func fetchTopSales() -> Single<[Product]> {
        return repository.fetchTopSales()
            .map({ entity in
                self.translator.translate(entity)
            })
    }
    
    func fetchProductYouMayLike() -> Single<[Product]> {
        return repository.fetchProductYouMayLike()
            .map({ entity in
                self.translator.translate(entity)
            })
    }
    
    func fetchNewProducts() -> Single<[Product]> {
        return repository.fetchNewProducts()
            .map({ entity in
                self.translator.translate(entity)
            })
    }
}
