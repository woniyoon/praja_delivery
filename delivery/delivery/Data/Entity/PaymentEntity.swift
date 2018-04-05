//
//  AccountEntity.swift
//  delivery
//
//  Created by Diego H. Vanni on 2018-03-25.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

struct PaymentEntity {
    public let cardNumber: String
    public let holderName: String
    public let expiryDate: String
    
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
            let expiryDate = dictionary["expiryDate"] as? String else { return nil }
        
        self.cardNumber = cardNumber
        self.holderName = holderName
        self.expiryDate = expiryDate
    }
}
