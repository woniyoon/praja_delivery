//
//  DeliveryTranslator.swift
//  delivery
//
//  Created by MATSUHISA MAI on 2018/03/12.
//  Copyright © 2018年 CICCC. All rights reserved.
//

import Foundation

class OrderTranslator: TranslatorProtocol {
    func translate(_ entity: ProductEntity) -> OrderModel {
        return OrderModel(
            //表示に必要なもの
        name: entity.name ?? "",
        price: entity.price,
        originalPrice: entity.originalPrice,
        images: entity.images)
    }
}
