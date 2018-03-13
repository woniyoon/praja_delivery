//
//  ProductDetailDataStoreProtocol.swift
//  delivery
//
//  Created by Kento Uchida on 2018/02/24.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

protocol ProductDetailDataStoreProtocol {
    func fetchProductDetail(_ id: String) -> ProductEntity
}
