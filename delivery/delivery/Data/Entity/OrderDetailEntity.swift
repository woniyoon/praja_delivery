//
//  OrderDetailEntity.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-03-19.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

struct OrderDetailEntity{
    var pricePerItem: Double
    var quantity: Int
    var productId: String
    
    init(pricePerItem: Double, quantity: Int, productId: String ) {
        self.pricePerItem = pricePerItem
        self.quantity = quantity
        self.productId = productId
    }
    
    var dictionary: [String: Any] {
        return [
            "pricePerItem": pricePerItem,
            "quantity": quantity,
            "productId": productId
        ]
    }
    
    init?(dictionary: [String: Any]) {
        guard let pricePerItem = dictionary["pricePerItem"] as? Double,
            let quantity = dictionary["quantity"] as? Int,
            let productId = dictionary["productId"] as? String else { return nil }
        
        self.pricePerItem = pricePerItem
        self.quantity = quantity
        self.productId = productId
    }
}
