//
//  ProductDetailRepository.swift
//  delivery
//
//  Created by Kento Uchida on 2018/02/24.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift

protocol ProductDetailRepositoryProtocol{
    func fetchProductDetail(_ id: String) -> Single<SampleProductEntity>
}

class ProductDetailRepository: ProductDetailRepositoryProtocol {
    
    private let dataStore: ProductDetailDataStoreProtocol
    
    init(dataStore: ProductDetailDataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    func fetchProductDetail(_ id: String) -> Single<SampleProductEntity>{
        return dataStore.fetchProductDetail(id)
    }
}
