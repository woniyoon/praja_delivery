//
//  OrderFirebaseDataStore.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-03-07.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import Firebase

class OrderFirebaseDataStore : OrderDataStoreProtocol {
    
    func makeAnOrder(_ order: Order, by id: String) {
        
    }
    
    func fetchOrders(_ id: String) -> OrderEntity {
        return OrderEntity()
    }
}

