//
//  HomeTranslator.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-03-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

class HomeTranslator: TranslatorProtocol {
    func translate(_ entity: [ProductEntity]) -> [Product] {
        var testArr = [Product]()
        for entity in entity {
            let product = Product(averageRating: entity.averageRating, branch: entity.branch, brand: entity.brand, description: entity.description, discountPercent: entity.discountPercent, events: entity.events, images: entity.images, name: entity.name, originalPrice: entity.originalPrice, price: entity.price, category: entity.category, subCategory: entity.subCategory, productId: entity.productId, reviews: translateReviews(entity.reviews), ratingCount: entity.ratingCount)
            
            testArr.append(product)
        }
        return testArr
    }
    
    private func translateReviews(_ reviews: [ReviewEntity]?) -> [Review]? {
        guard let reviews = reviews else { return nil }
        return reviews.map{ r in
            Review(userId: r.userId, userName: r.userName, title: r.title, comment: r.comment, rating: r.rating, date: r.date)
        }
    }
}
