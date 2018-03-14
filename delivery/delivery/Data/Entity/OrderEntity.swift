//
//  UserEntity.swift
//  delivery
//
//  Created by MATSUHISA MAI on 2018/03/12.
//  Copyright © 2018年 CICCC. All rights reserved.
//

import Foundation

enum Status : String{
    case ordered = "ordered"
    case confirmed = "confirmed"
    case packed = "packed"
    case shipping = "shipping"
    case delivered = "delivered"
    case canceled = "canceled"
}

struct OrderEntity {
    public let orderNumber: Int
    public let trackingNumber: Int
    public let dateOfPurchase: Date
    public let scheduledDeliveryDate: Date
    public let totalPrice: Int
    public let shippingAddress: String
    public let deliveryFee: Int
    public let status : Status
    public let cancelReason: String
    public let userId: Int
    
    var dictionary: [String: Any] {
        return [
            "orderNumber": orderNumber,
            "trackingNumber": trackingNumber,
            "dateOfPurchase": dateOfPurchase,
            "scheduledDeliveryDate": scheduledDeliveryDate,
            "totalPrice": totalPrice,
            "shippingAddress": shippingAddress,
            "deliveryFee": deliveryFee,
            "status": status,
            "cancelReason": cancelReason,
            "userId": userId
        ]
    }
}
