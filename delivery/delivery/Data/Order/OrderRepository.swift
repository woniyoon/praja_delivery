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
    func fetchOrder(with userId: String) -> Single<[OrderEntity]>
    func fetchOrderDetail(with orderId: String) -> Single<OrderEntity>
//    func fetchOrderProduct(with productId: String) -> Single<ProductEntity>
}

class OrderRepository : OrderRepositoryProtocol{
    
    private let dataStore: OrderDataStoreProtocol

    init(dataStore: OrderDataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    func fetchOrder(with userId: String) ->
        Single<[OrderEntity]> {
            return dataStore.fetchOrder(with:userId)
    }
    
    func fetchOrderDetail(with orderId: String) -> Single<OrderEntity>{
        return dataStore.fetchOrderDetail(with:orderId)
    }
    
//    func fetchOrderProduct(with productId: String) ->
//        Single<ProductEntity> {
//            return dataStore.fetchOrderProduct(with:productId)
//    }
}

