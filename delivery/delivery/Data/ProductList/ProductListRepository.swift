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
    func fetchProductList(with keyword: String) -> Single<[ProductEntity]>
    func fetchProductList2() -> [ProductEntity]
}

class ProductListRepository: ProductListRepositoryProtocol {

    private let dataStore: ProductListDataStoreProtocol
    
    init(dataStore: ProductListDataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    func fetchProductList2() -> [ProductEntity] {
        return dataStore.fetchProductList2()
    }
    
    func fetchProductList(with keyword: String) -> Single<[ProductEntity]> {
        return dataStore.fetchProductList(with: keyword)
    }
}
