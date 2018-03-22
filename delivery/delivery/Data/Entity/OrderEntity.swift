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
    public let orderNumber: String
    public let trackingNumber: String
    public let dateOfPurchase: Date
    public let scheduledDeliveryDate: Date
    public let totalPrice: Double
    public let shippingAddress: Address
    public let deliveryFee: Double
    public let status: Status
    public let cancelReason: String
    public let userId: String
    public let orderDetail: [OrderDetail] //not sure...
    public let deliveryInfo: DeliveryInfo //not sure..
    public let pointStatement: PointStatement
    public let remark: String

    
    init?(dictionary: [String: Any]) {
        guard let orderNumber = dictionary["orderNumber"] as? String,
            let trackingNumber = dictionary["trackingNumber"] as? String,
            let dateOfPurchase = dictionary["dateOfPurchase"] as? Date,
            let scheduledDeliveryDate = dictionary["scheduledDeliveryDate"] as? Date,
            let totalPrice = dictionary["totalPrice"] as? Double,
            let shippingAddress = dictionary["shippingAddress"] as? Address,
            let deliveryFee = dictionary["deliveryFee"] as? Double,
            let status = dictionary["status"] as? String,
            let cancelReason = dictionary["cancelReason"] as? String,
            let userId = dictionary["userId"] as? String,
            let orderDetail = dictionary["orderDetail"] as? [OrderDetail],
            let deliveryInfo = dictionary["deliveryInfo"] as? DeliveryInfo,
            let pointStatement = dictionary["pointStatement"] as? PointStatement,
            let remark = dictionary["remark"] as? String else { return nil }
        
        self.orderNumber = orderNumber
        self.trackingNumber = trackingNumber
        self.dateOfPurchase = dateOfPurchase
        self.scheduledDeliveryDate = scheduledDeliveryDate
        self.totalPrice = totalPrice
        self.shippingAddress = shippingAddress
        self.deliveryFee = deliveryFee
        self.status = Status.init(rawValue: status)! // not sure.....
        self.cancelReason = cancelReason
        self.userId = userId
        self.orderDetail = orderDetail
        self.deliveryInfo = deliveryInfo
        self.pointStatement = pointStatement
        self.remark = remark
    }
    
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
            "userId": userId,
            "orderDetail": orderDetail,
            "deliveryInfo": deliveryFee,
            "pointStatement": pointStatement,
            "remark": remark
        ]
    }
}
