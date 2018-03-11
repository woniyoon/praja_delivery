//
//  ProductDetailFirebaseDataStore.swift
//  delivery
//
//  Created by Kento Uchida on 2018/02/24.
//  Copyright © 2018 CICCC. All rights reserved.
//
import Foundation

class ProductDetailFirebaseDataStore: ProductDetailDataStoreProtocol {
    
    func fetchProductDetail(_ id: String) -> ProductDetailEntity {
        print("REEEEEEEEACH! TO DATA STAOREEEEEEEEEEEEEEEEE \(id)")
        return ProductDetailEntity()
    }
}
