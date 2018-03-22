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
    public let branch: [BranchInvetoryEntity]
    public let brand: String
    public let description: String
    public let discountPercent: Int
    public let events: [String : Bool]
    public let images: [String]
    public let name: String
    public let originalPrice: Double
    public let price: Double
    public let subCategory: String
    public let category: String
    
    
    init?(dictionary: [String: Any]) {
        guard let name = dictionary["name"] as? String,
            let brand = dictionary["brand"] as? String,
            let description = dictionary["description"] as? String,
            let discountPercent = dictionary["discountPercent"] as? Int,
            let images = dictionary["images"] as? [String],
            let originalPrice = dictionary["originalPrice"] as? Double,
            let price = dictionary["price"] as? Double,
            let subCategory = dictionary["subCategory"] as? String,
            let category = dictionary["category"] as? String else { return nil }

        var temp: [BranchInvetoryEntity]  = []
        for branch in dictionary["branch_arr"] as! [Any] {
            temp.append(BranchInvetoryEntity(dictionary: (branch as? [String : Any]) ?? [:])!)
        }
        self.branch = temp
        
//        print("=== branch \(branch)")
//        guard let brand = dictionary["brand"] as? String else { return nil }
//        print("= brand = \(brand)")
//        guard let description = dictionary["description"] as? String else { return nil }
//        print("= desc = \(description)")
//        guard let discountPercent = dictionary["discountPercent"] as? Int else { return nil }
//        print("= discount = \(discountPercent)")
//        guard let images = dictionary["images"] as? [String] else { return nil }
//        print("= img = \(images)")
//        guard let originalPrice = dictionary["originalPrice"] as? Double else { return nil }
//        print("= originalPrice = \(originalPrice)")
//        guard let price = dictionary["price"] as? Double else { return nil }
//        print("= price = \(price)")
//        guard let subCategory = dictionary["subCategory"] as? String else { return nil }
//        print("= subCategory = \(subCategory)")
//        guard let category = dictionary["category"] as? String else { return nil }
//        print("= category = \(category)")
        
        
        let averageRating = dictionary["averageRating"] as? Double ?? 0.0
        
        let events = dictionary["event"] as? [String : Bool] ?? [:]
        print("= event = \(events)")
        
        self.averageRating = averageRating
        self.brand = brand
        self.description = description
        self.discountPercent = discountPercent
        self.events = events
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

