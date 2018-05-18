//
//  ProductDetailEntity.swift
//  delivery
//
//  Created by Kento Uchida on 2018/02/24.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

struct ProductEntity {
    public let averageRating: Double
    public let branch: [BranchInventoryEntity]
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
    public let productId: String
    public var reviews: [ReviewEntity]?

    init?(docId: String, dictionary: [String: Any]) {
        guard let name = dictionary["name"] as? String,
            let brand = dictionary["brand"] as? String,
            let description = dictionary["description"] as? String,
            let discountPercent = dictionary["discountPercent"] as? Int,
            let images = dictionary["images"] as? [String],
            let originalPrice = dictionary["originalPrice"] as? Double,
            let price = dictionary["price"] as? Double,
            let subCategory = dictionary["subCategory"] as? String,
            let category = dictionary["category"] as? String else { return nil }

        let productId = docId
        
        var branchArr: [BranchInventoryEntity]  = []
        for branch in dictionary["branch"] as! [Any] {
            branchArr.append(BranchInventoryEntity(dictionary: (branch as? [String : Any]) ?? [:])!)
        }
        self.branch = branchArr
    
        let averageRating = dictionary["averageRating"] as? Double ?? 0.0
        
        let events = dictionary["event"] as? [String : Bool] ?? [:]
        
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
        self.productId = productId
    }
}

