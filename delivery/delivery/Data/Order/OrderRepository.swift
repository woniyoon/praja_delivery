//
//  DeliveryRepository.swift
//  delivery
//
//  Created by MATSUHISA MAI on 2018/03/12.
//  Copyright © 2018年 CICCC. All rights reserved.
//

import Foundation

protocol OrderRepositoryProtocol{
    func fetchOrder(_ id : String) ->
//    OrderEntity
    ProductEntity
}

class OrderRepository : OrderRepositoryProtocol{
    private let dataStore: OrderDataStoreProtocol

    init(dataStore: OrderDataStoreProtocol) {
        self.dataStore = dataStore
    }

    func fetchOrder(_ id: String) -> ProductEntity {
        return dataStore.fetchOrder(id)
    }
}

