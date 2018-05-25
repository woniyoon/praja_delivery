//
//  Order.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-03-17.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

struct Order {
//    public let dateOfPurchase: Date
    public let remark: String
    public let pointStatement: PointStatement
    public let userId: String
    public let orderDetail: [OrderDetail]
    public let scheduledDeliveryDate: Date
    public let cancelReason: String?
    public let status: Status
    public let deliveryFee: Double
    public let shippingAddress: Address
    public let totalPrice: Double
    public let orderNumber: String?
    public let trackingNumber: String?
    public let deliveryInfo: [String : Date]

    init?(dictionary: [String: Any]) {
        guard let orderNumber = dictionary["orderNumber"] as? String,
            let trackingNumber = dictionary["trackingNumber"] as? String,
            //            let dateOfPurchase = dictionary["dateOfPurchase"] as? Date,
            let scheduledDeliveryDate = dictionary["scheduledDeliveryDate"] as? Date,
            let totalPrice = dictionary["totalPrice"] as? Double,
            let shippingAddress = dictionary["shippingAddress"] as? Address,
            let deliveryFee = dictionary["deliveryFee"] as? Double,
            let status = dictionary["status"] as? Status,
            let userId = dictionary["userId"] as? String,
            let orderDetail = dictionary["orderDetail"] as? [OrderDetail],
            let deliveryInfo = dictionary["deliveryInfo"] as? [String : Date],
            let pointStatement = dictionary["pointStatement"] as? PointStatement,
            let remark = dictionary["remark"] as? String,
            let cancelReason = dictionary["cancelReason"] as? String else { return nil }
        
        self.orderNumber = orderNumber
        self.trackingNumber = trackingNumber
        //        self.dateOfPurchase = dateOfPurchase
        self.scheduledDeliveryDate = scheduledDeliveryDate
        self.totalPrice = totalPrice
        self.shippingAddress = shippingAddress
        self.deliveryFee = deliveryFee
        self.status = status // not sure.....
        self.cancelReason = cancelReason
        self.userId = userId
        self.orderDetail = orderDetail
        self.deliveryInfo = deliveryInfo
        self.pointStatement = pointStatement
        self.remark = remark
    }
    
    var dictionary: [String: Any] {
        return [
//            "dateOfPurchase": dateOfPurchase,
            "remark": remark,
            "pointStatement": pointStatement,
            "userId": userId,
            "orderDetail": orderDetail,
            "scheduledDeliveryDate": scheduledDeliveryDate,
            "cancelReason": cancelReason as Any,
            "status": status,
            "deliveryFee": deliveryFee,
            "shippingAddress": shippingAddress,
            "totalPrice": totalPrice,
            "orderNumber": orderNumber ?? "",
            "trackingNumber": trackingNumber ?? "",
            "deliveryInfo": deliveryInfo
        ]
    }
}

