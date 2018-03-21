//
//  PaymentEntity.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-03-18.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

struct PaymentEntity {
    public let cardNumber: String
    public let holderName: String
    public let expiryDate: Date
    
    var dictionary: [String: Any] {
        return [
            "cardNumber": cardNumber,
            "holderName": holderName,
            "expiryDate": expiryDate,
        ]
    }
    
    init?(dictionary: [String: Any]) {
        guard let cardNumber = dictionary["cardNumber"] as? String,
            let holderName = dictionary["holderName"] as? String,
            let expiryDate = dictionary["expiryDate"] as? Date else { return nil }
        
        self.cardNumber = cardNumber
        self.holderName = holderName
        self.expiryDate = expiryDate
    }
}
