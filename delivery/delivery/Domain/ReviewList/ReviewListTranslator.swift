//
//  ReviewListTranslator.swift
//  delivery
//
//  Created by Kento Uchida on 2018/03/23.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

class ReviewListTranslator: TranslatorProtocol {
    func translate(_ reviews: [ReviewEntity]?) -> [Review] {
        guard let reviews = reviews else { return [] }
        return reviews.map{ r in
            Review(userId: r.userId, userName: r.userName, title: r.title, comment: r.comment, rating: r.rating, date: r.date)
        } 
    }
}
