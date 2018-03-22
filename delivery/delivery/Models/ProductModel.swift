//
//  Product.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-02-20.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

struct ProductModel {
    public let averageRating: Double
    public let branch: BranchInvetory
    public let brand: String
    public let description: String
    public let discountPercent: Int?
    public let event: EventEntity?
    public let images: [String]
    public let name: String
    public let originalPrice: Double
    public let price: Double
    public let category: String
    public let subCategory: String
    
    var dictionary: [String: Any] {
        return [
            "averageRating": averageRating,
            "branch": branch,
            "brand": brand,
            "description": description,
            "discountPercent": discountPercent as Any,
            "event": event as Any,
            "images": images,
            "name": name,
            "originalPrice": originalPrice,
            "price": price,
            "subCategory": subCategory,
            "category": category
        ]
    }
}
