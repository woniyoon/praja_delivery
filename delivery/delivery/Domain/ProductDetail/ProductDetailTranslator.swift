//
//  ProductDetailTranslator.swift
//  delivery
//
//  Created by Kento Uchida on 2018/02/24.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

class ProductDetailTranslator: TranslatorProtocol {
    func translate(_ entity: SampleProductEntity) -> SampleProductModel {
        return SampleProductModel(
            name: entity.name ?? "",
            price: entity.price,
            originalPrice: entity.originalPrice,
            description: entity.description)
    }
}
