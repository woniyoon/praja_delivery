//
//  ProductDetailEntity.swift
//  delivery
//
//  Created by Kento Uchida on 2018/02/24.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

struct ProductEntity {
    public let name: String
    public let brand: String
    public let price: Double
    public let originalPrice: Double
    public let discountPercent: Double
    public let images: [String]?
    public let averageRating: Float
    public let fiveStarsCount: Int
    public let fourStarsCount: Int
    public let threeStarsCount: Int
    public let twoStarsCount: Int
    public let oneStarCount: Int
    public let description: String
    
    public let category: String
    public let subCategory: String
}
