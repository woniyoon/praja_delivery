//
//  OrderDetail.swift
//  delivery
//
//  Created by Sara N on 2018-02-20.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

class OrderDetail{
    
    var price: Double
    var quantity: Int
    var orderId: String
    var productId: String
    
    init(price: Double, quantity: Int, orderId: String, productId: String ) {
        self.price = price
        self.quantity = quantity
        self.orderId = orderId
        self.productId = productId
    }
}
