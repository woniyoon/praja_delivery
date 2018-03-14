//
//  ProductListDataStoreProtocol.swift
//  delivery
//
//  Created by Bacelar on 2018-03-06.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

protocol ProductListDataStoreProtocol {
    func fetchProductList() -> [ProductEntity]
}
