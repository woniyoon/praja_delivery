//
//  HomeTranslator.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-03-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

class HomeTranslator: TranslatorProtocol {
    func translate(_ entity: ProductEntity) -> ProductModel {
        return ProductModel(name: entity.name, price: entity.price, originalPrice: entity.price)
    }
}
