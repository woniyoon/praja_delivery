//
//  AccountEntity.swift
//  delivery
//
//  Created by Diego H. Vanni on 2018-03-25.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

struct Payment {
    public let cardNumber: String
    public let holderName: String
    public let expiryDate: String
    public let isDefault: Bool
    
    var dictionary: [String: Any] {
        return [
            "cardNumber": cardNumber,
            "holderName": holderName,
            "expiryDate": expiryDate,
            "isDefault": isDefault
        ]
    }
}
