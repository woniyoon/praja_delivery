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
        return Order(remark: entity.remark, pointStatement: entity.pointStatement, userId: entity.userId, orderDetail: entity.orderDetail, scheduledDeliveryDate: entity.scheduledDeliveryDate, cancelReason: entity.cancelReason, status: entity.status, deliveryFee: entity.deliveryFee, shippingAddress: entity.shippingAddress, totalPrice: entity.totalPrice, orderNumber: entity.orderNumber, trackingNumber: entity.trackingNumber, dateInfo: entity.dateInfo)
    }
}
