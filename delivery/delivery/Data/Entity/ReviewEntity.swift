//
//  ReviewEntity.swift
//  delivery
//
//  Created by Kento Uchida on 2018/03/11.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

struct ReviewEntity {
    public let comment: String
    public let date: Date
    public let productId: String
    public let rating: Double
    public let title: String
    public let userId: String
    public let userName: String
    
    init?(dictionary: [String: Any]) {
        guard let comment = dictionary["comment"] as? String,
            let date = dictionary["date"] as? Date,
            let productId = dictionary["productId"] as? String,
            let rating = dictionary["rating"] as? Double,
            let title = dictionary["title"] as? String,
            let userId = dictionary["userId"] as? String,
            let userName = dictionary["userName"] as? String else { return nil }
        
        self.comment = comment
        self.date = date
        self.productId = productId
        self.rating = rating
        self.title = title
        self.userId = userId
        self.userName = userName
    }
}
