//
//  ProductDetailRepository.swift
//  delivery
//
//  Created by Kento Uchida on 2018/02/24.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

protocol ProductDetailRepositoryProtocol{
    func fetchProductDetail(_ id: String) -> ProductDetailEntity
}

class ProductDetailRepository: ProductDetailRepositoryProtocol {
    
    private let dataStore: ProductDetailDataStoreProtocol
    
    init(dataStore: ProductDetailDataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    func fetchProductDetail(_ id: String) -> ProductDetailEntity {
        return dataStore.fetchProductDetail(id)
    }
}
