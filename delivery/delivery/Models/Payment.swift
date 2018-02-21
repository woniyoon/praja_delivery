//
//  Payment.swift
//  delivery
//
//  Created by Sara N on 2018-02-20.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
class Payment{
    
    var cardNumber: Int
    var holderName: String
    var expiryDate: Date
    var userId: String
    
    init(cardNumber: Int, holderName: String, expiryDate: Date, userId: String) {
        self.cardNumber = cardNumber
        self.holderName = holderName
        self.expiryDate = expiryDate
        self.userId = userId
    }
}
