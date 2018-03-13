//
//  OrderDataStoreProtocol.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-03-07.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

protocol OrderDataStoreProtocol {
    func fetchOrders(_ id: String) -> OrderEntity
    
    func makeAnOrder(_ order: Order, by id: String) -> Void
}
