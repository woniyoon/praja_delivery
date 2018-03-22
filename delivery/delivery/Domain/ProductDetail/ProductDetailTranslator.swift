//
//  ProductDetailTranslator.swift
//  delivery
//
//  Created by Kento Uchida on 2018/02/24.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

class ProductDetailTranslator: TranslatorProtocol {
    func translate(_ entity: ProductEntity) -> ProductModel {
        return ProductModel(averageRating: entity.averageRating, branch: BranchInvetory(quantity: entity.branch.quantity, name: entity.branch.name), brand: entity.brand, description: entity.description, discountPercent: entity.discountPercent, event: entity.event, images: entity.images, name: entity.name, originalPrice: entity.originalPrice, price: entity.price, category: entity.category, subCategory: entity.subCategory)
    }
}
