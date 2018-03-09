//
//  ProductListRepository.swift
//  delivery
//
//  Created by Bacelar on 2018-03-06.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

protocol ProductListRepositoryProtocol{
    func fetchProductList() -> [ProductEntity]
    func addNewProduct(product: ProductEntity)
}

class ProductListRepository: ProductListRepositoryProtocol {

    private let dataStore: ProductListDataStoreProtocol
    
    init(dataStore: ProductListDataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    func fetchProductList() -> [ProductEntity] {
        return dataStore.fetchProductList()
    }
    
    func addNewProduct(product: ProductEntity) {
        dataStore.addNewProduct(product: product)
    }
}
