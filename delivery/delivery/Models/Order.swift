//
//  Order.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-03-17.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

struct Order {
    public let dateOfPurchase: Date
    public let remark: String
    public let pointStatement: PointStatement
    public let userId: String
    public let orderDetail: [OrderDetail]
    public let scheduledDeliveryDate: Date
    public let cancelReason: String?
    public let status: Status?
    public let deliveryFee: Double
    public let shippingAddress: Address
    public let totalPrice: Double
    public let orderNumber: String?
    public let trackingNumber: String?
    public let deliveryInfo: DeliveryInfo?

    var dictionary: [String: Any] {
        return [
            "dateOfPurchase": dateOfPurchase,
            "remark": remark,
            "pointStatement": pointStatement,
            "userId": userId,
            "orderDetail": orderDetail,
            "scheduledDeliveryDate": scheduledDeliveryDate,
            "cancelReason": cancelReason as Any,
            "deliveryFee": deliveryFee,
            "shippingAddress": shippingAddress,
            "totalPrice": totalPrice
        ]
    }
}

