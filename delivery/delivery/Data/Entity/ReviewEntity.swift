//
//  ReviewEntity.swift
//  delivery
//
//  Created by Kento Uchida on 2018/03/11.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

struct ReviewEntity {
    public let title: String
    public let rating: Int
    public let userID: String
    public let username: String
    public let comment: String
    public let date: Date
    
    var dictionary: [String: Any] {
        return [
            "title": title,
            "rating": rating,
            "userId": userID,
            "userName": username,
            "comment": comment,
            "timestamp": date
        ]
    }
}
