//
//  ProductDetailEntity.swift
//  delivery
//
//  Created by Kento Uchida on 2018/02/24.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

//struct ProductEntity {
//    public let name: String
//    public let brand: String
//    public let price: Double
//    public let originalPrice: Double
//    public let discountPercent: Double
//    public let images: [String]?
//    public let averageRating: Float
//    public let fiveStarsCount: Int
//    public let fourStarsCount: Int
//    public let threeStarsCount: Int
//    public let twoStarsCount: Int
//    public let oneStarCount: Int
//    public let description: String
//
//    public let category: String
//    public let subCategory: String
//}

struct ProductEntity {

    public let averageRating: Double
    public let branch: [String : BranchInvetory]
    public let brand: String
    public let description: String
    public let discountPercent: Int?
    public let event: EventEntity?
    public let images: [String]
    public let name: String
    public let originalPrice: Double
    public let price: Double
    public let subCategory: String
    public let category: String


    init?(dictionary: [String: Any]) {
        guard let averageRating = dictionary["averageRating"] as? Double,
            let branch = dictionary["branch"],
            let brand = dictionary["brand"] as? String,
            let description = dictionary["description"] as? String,
            let discountPercent = dictionary["discountPercent"] as? Int,
            let event = dictionary["event"] as? EventEntity,
            let images = dictionary["images"] as? [String],
            let name = dictionary["name"] as? String,
            let originalPrice = dictionary["originalPrice"] as? Double,
            let price = dictionary["price"] as? Double,
            let subCategory = dictionary["subCategory"] as? String,
            let category = dictionary["category"] as? String else { return nil }
        
        self.averageRating = averageRating
        self.branch = branch as! [String : BranchInvetory]
        self.brand = brand
        self.description = description
        self.discountPercent = discountPercent
        self.event = event
        self.images = images
        self.name = name
        self.originalPrice = originalPrice
        self.price = price
        self.subCategory = subCategory
        self.category = category
    }
    
//        init(name: String, description: String, price: Double, brand: String, discountPercent: Int, subCategory: SubCategory, images: [String]) {
//            self.name = name
//            self.description = description
//            self.price = price
//            self.brand = brand
//            self.discountPercent = discountPercent
//            self.subCategory = subCategory
//            self.images = images
//        }

}

