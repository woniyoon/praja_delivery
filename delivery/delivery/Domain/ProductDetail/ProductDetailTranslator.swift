//
//  ProductDetailTranslator.swift
//  delivery
//
//  Created by Kento Uchida on 2018/02/24.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

class ProductDetailTranslator {
    func translateList(from list: [ProductEntity]) -> [Product] {
        return list.map { entity in translate(from: entity) }
    }
    
    func translate(from entity: ProductEntity) -> Product {
        return Product(averageRating: entity.averageRating,
                       branch: entity.branch,
                       brand: entity.brand,
                       description: entity.description,
                       discountPercent: entity.discountPercent,
                       events: entity.events,
                       images: entity.images,
                       name: entity.name,
                       originalPrice: entity.originalPrice,
                       price: entity.price,
                       category: entity.category,
                       subCategory: entity.subCategory,
                       productId: entity.productId)
    }
}
