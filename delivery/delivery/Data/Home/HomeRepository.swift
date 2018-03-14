//
//  HomeRepository.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-03-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

protocol HomeRepositoryProtocol{
    func fetchProducts() -> ProductEntity
}

class HomeRepository: HomeRepositoryProtocol {

    private let dataStore: HomeDataStoreProtocol
    
    init(dataStore: HomeDataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    func fetchProducts() -> ProductEntity {
        return dataStore.fetchProducts()
    }
}
