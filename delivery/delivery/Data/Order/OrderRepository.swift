//
//  DeliveryRepository.swift
//  delivery
//
//  Created by MATSUHISA MAI on 2018/03/12.
//  Copyright © 2018年 CICCC. All rights reserved.
//

import Foundation
import RxSwift

protocol OrderRepositoryProtocol{
    func fetchOrder(_ id : String) -> Single<OrderEntity>
}

class OrderRepository : OrderRepositoryProtocol{
    private let dataStore: OrderDataStoreProtocol

    init(dataStore: OrderDataStoreProtocol) {
        self.dataStore = dataStore
    }

    func fetchOrder(_ id: String) -> Single<OrderEntity> {
        return dataStore.fetchOrder(id)
    }
}
