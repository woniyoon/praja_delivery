//
//  OrderRepository.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-03-07.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

protocol OrderRepositoryProtocol{
    func fetchOrders(_ id: String) -> OrderEntity
    func makeAnOrder(_ order: Order, by id: String) -> Void
}

class OrderRepository : OrderRepositoryProtocol {
    
    private let dataStore: OrderDataStoreProtocol
    
    init(dataStore: OrderDataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    func makeAnOrder(_ order: Order, by id: String) {
        dataStore.makeAnOrder(order, by: id)
    }
    
    func fetchOrders(_ id: String) -> OrderEntity {
        return dataStore.fetchOrders(id)
    }
}
