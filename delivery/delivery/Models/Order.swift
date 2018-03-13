//
//  Order.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-03-05.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

enum Status {
    case pending
    case confirmed
    case packed
    case shipping
    case delivered
    case canceled
}

struct Order {
    public let orderNumber: String
    public let trackingNumber: String
    public let dateOfPurchase: Date
    public let scheduledDeliveryDate: Date
    public let totalPrice: Double
    public let shippingAddress: String
    public let deliveryFee: Double
    public let status: Status
    public let canceledReason: String?
    public let userId: String
    public let deliveryInfo: DeliveryInfo?
    public let orderDetail: [OrderDetail]
    
}

