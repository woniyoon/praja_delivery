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
<<<<<<< HEAD
    
    public let name: String
    public let price: Double
    public let originalPrice: Double
    public let description: String
    
    init?(dictionary: [String: Any]) {
        guard let name = dictionary["name"] as? String,
            let price = dictionary["price"] as? Double,
            let originalPrice = dictionary["originalPrice"] as? Double,
            let description = dictionary["description"] as? String else { return nil }
        
        self.name = name
        self.price = price
        self.originalPrice = originalPrice
        self.description = description
    }
    
    
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
//
=======
    public let averageRating: Double
    public let branch: BranchInvetoryEntity
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
        print("dictionary======================")
        guard let name = dictionary["name"] as? String else { return nil }
        print("=== \(name)")
        self.branch = BranchInvetoryEntity(dictionary: (dictionary["branch"] as? [String : Any])!)!
        print("=== \(branch)")
        let averageRating = dictionary["averageRating"] as? Double ?? 0.0
        print("=== \(averageRating)")
            guard let brand = dictionary["brand"] as? String else { return nil }
        print("=== \(brand)")
            guard let description = dictionary["description"] as? String else { return nil }
        print("=== \(description)")
            guard let discountPercent = dictionary["discountPercent"] as? Int else { return nil }
        print("=== \(discountPercent)")
            guard let event = dictionary["event"] as? EventEntity else { return nil }
        print("=== \(event)")
            guard let images = dictionary["images"] as? [String] else { return nil }
        print(images)
            guard let originalPrice = dictionary["originalPrice"] as? Double else { return nil }
        print(originalPrice)
            guard let price = dictionary["price"] as? Double else { return nil }
        print(price)
            guard let subCategory = dictionary["subCategory"] as? String else { return nil }
        print(subCategory)
            guard let category = dictionary["category"] as? String else { return nil }
        print(category)
        
        self.averageRating = averageRating
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

>>>>>>> 11c8083f2862c9ed482d30204ab1cc432482a6d7
}

