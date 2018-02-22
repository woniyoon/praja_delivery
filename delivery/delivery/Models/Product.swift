//
//  Product.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-02-20.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

class Product {
    private(set) public var name: String
    private(set) public var description: String
    private(set) public var price: Double
    private(set) public var brand: String
    private(set) public var discountPercent: Int? = nil
    private(set) public var subCategory: SubCategory
    private(set) public var images: [String]
    
    init(name: String, description: String, price: Double, brand: String, discountPercent: Int, subCategory: SubCategory, images: [String]) {
        self.name = name
        self.description = description
        self.price = price
        self.brand = brand
        self.discountPercent = discountPercent
        self.subCategory = subCategory
        self.images = images
    }
    
}
