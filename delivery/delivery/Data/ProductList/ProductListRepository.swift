//
//  ProductListRepository.swift
//  delivery
//
//  Created by Bacelar on 2018-03-06.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift

protocol ProductListRepositoryProtocol{
    func fetchProductList() -> [SampleProductEntity]
}

class ProductListRepository: ProductListRepositoryProtocol {

    private let dataStore: ProductListDataStoreProtocol
    
    init(dataStore: ProductListDataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    func fetchProductList() -> [SampleProductEntity] {
        return dataStore.fetchProductList()
    }
    
}
