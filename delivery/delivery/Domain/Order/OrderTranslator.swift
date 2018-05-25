//
//  DeliveryTranslator.swift
//  delivery
//
//  Created by MATSUHISA MAI on 2018/03/12.
//  Copyright © 2018年 CICCC. All rights reserved.
//

import Foundation

class OrderTranslator: TranslatorProtocol {
    func translate(_ entity: OrderEntity) -> Order {
        
        return Order(dictionary: ["remark": entity.remark,
                                        "pointStatement": entity.pointStatement,
                                        "userId": entity.userId,
                                        "orderDetail": entity.orderDetail,
                                        "scheduledDeliveryDate": entity.scheduledDeliveryDate,
                                        "cancelReason": entity.cancelReason,
                                        "status": entity.status,
                                        "deliveryFee": entity.deliveryFee,
                                        "shippingAddress": entity.shippingAddress,
                                        "totalPrice": entity.totalPrice,
                                        "orderNumber": entity.orderNumber,
                                        "trackingNumber": entity.trackingNumber,
                                        "dateInfo": entity.deliveryInfo])!
        
    }
    
    func translateToEntity(_ model: Order) -> OrderEntity {
        
        return OrderEntity(dictionary: ["remark": model.remark,
                           "pointStatement": model.pointStatement,
                           "userId": model.userId,
                           "orderDetail": model.orderDetail,
                           "scheduledDeliveryDate": model.scheduledDeliveryDate,
                           "cancelReason": model.cancelReason,
                           "status": model.status,
                           "deliveryFee": model.deliveryFee,
                           "shippingAddress": model.shippingAddress,
                           "totalPrice": model.totalPrice,
                           "orderNumber": model.orderNumber,
                           "trackingNumber": model.trackingNumber,
                           "deliveryInfo": model.deliveryInfo])!
    }
}
