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
        return entity.map{ entity in
            Product(averageRating: entity.averageRating,
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
                    productId: entity.productId,
                    reviews: translateReviews(entity.reviews),
                    ratingCount: entity.ratingCount)
        }
    }
    
    func translateBranch(from branch: [BranchInventoryEntity]) -> [BranchInventory] {
        var arr: [BranchInventory] = []
        
        branch.forEach { (element) in
            arr.append(BranchInventory(quantity: element.quantity, name: element.name))
        }
        return arr
    }

    private func translateReviews(_ reviews: [ReviewEntity]?) -> [Review]? {
        guard let reviews = reviews else { return nil }
        return reviews.map{ r in
            Review(userId: r.userId, userName: r.userName, title: r.title, comment: r.comment, rating: r.rating, date: r.date)
        }
    }
}
