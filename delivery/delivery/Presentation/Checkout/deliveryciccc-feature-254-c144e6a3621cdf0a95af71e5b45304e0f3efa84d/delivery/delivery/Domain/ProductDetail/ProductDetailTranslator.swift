//
//  ProductDetailTranslator.swift
//  delivery
//
//  Created by Kento Uchida on 2018/02/24.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

class ProductDetailTranslator: TranslatorProtocol {
    func translate(_ entity: ProductEntity) -> Product {
        return Product(
            averageRating: entity.averageRating,
            branch: translateBranch(from: entity.branch),
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
    
    func translateBranch(from branch: [BranchInventoryEntity]) -> [BranchInventory] {
        var arr: [BranchInventory] = []
        
        branch.forEach { (element) in
            arr.append(BranchInventory(quantity: element.quantity, name: element.name))
        }
        return arr
    }
}
