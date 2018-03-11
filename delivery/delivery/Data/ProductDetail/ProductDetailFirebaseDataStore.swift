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
        return ProductDetailEntity(
            name: "Sour Patch Kids Sweet and Sour Gummy Candy (Strawberry, 10 Ounce Bag, Pack of 12)",
            price: 13.87,
            originalPrice: 15.00,
            image: "")
    }
}
