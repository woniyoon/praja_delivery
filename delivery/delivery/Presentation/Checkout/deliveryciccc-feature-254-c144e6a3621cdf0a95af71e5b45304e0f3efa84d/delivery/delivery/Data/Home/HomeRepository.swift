//
//  HomeRepository.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-03-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift

protocol HomeRepositoryProtocol{
    func fetchTopSales() -> Single<[ProductEntity]>
    func fetchProductYouMayLike() -> Single<[ProductEntity]>
    func fetchNewProducts() -> Single<[ProductEntity]>
}

class HomeRepository: HomeRepositoryProtocol {

    private let dataStore: HomeDataStoreProtocol
    
    init(dataStore: HomeDataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    func fetchTopSales() -> Single<[ProductEntity]> {
        return dataStore.fetchTopSales()
    }
    
    func fetchProductYouMayLike() -> Single<[ProductEntity]> {
        return dataStore.fetchProductYouMayLike()
    }
    
    func fetchNewProducts() -> PrimitiveSequence<SingleTrait, [ProductEntity]> {
        return dataStore.fetchNewProducts()
    }
}
