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
    func fetchProducts() -> Single<ProductEntity>
}

class HomeRepository: HomeRepositoryProtocol {

    private let dataStore: HomeDataStoreProtocol
    
    init(dataStore: HomeDataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    func fetchProducts() -> Single<ProductEntity> {
        return dataStore.fetchProducts()
    }
}
