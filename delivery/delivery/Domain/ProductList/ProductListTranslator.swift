//
//  ProductListTranslator.swift
//  delivery
//
//  Created by Bacelar on 2018-03-13.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

class ProductListTranslator: TranslatorProtocol {
    func translate(_ entities: [ProductEntity]) -> [Product] {
        
        var products = [Product]()
        
        for entity in entities {
            products.append( Product(averageRating: entity.averageRating, branch: entity.branch, brand: entity.brand, description: entity.description, discountPercent: entity.discountPercent, events: entity.events, images: entity.images, name: entity.name, originalPrice: entity.originalPrice, price: entity.price, category: entity.category, subCategory: entity.subCategory, productId: entity.productId, reviews: translateReviews(entity.reviews), ratingCount: entity.ratingCount))
        }
        
        return products
    }
    
    private func translateReviews(_ reviews: [ReviewEntity]?) -> [Review]? {
        guard let reviews = reviews else { return nil }
        return reviews.map{ r in
            Review(userId: r.userId, userName: r.userName, title: r.title, comment: r.comment, rating: r.rating, date: r.date)
        }
    }
}
