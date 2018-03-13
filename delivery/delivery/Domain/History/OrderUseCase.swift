//
//  HistoryUseCase.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-03-09.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

protocol OrderUseCaseProtocol {
    func fetchOrders(_ id: String) -> Order
}

class OrderUseCase: OrderUseCaseProtocol {
    
    internal let repository: OrderRepositoryProtocol
    internal let translator: OrderTranslator
    
    init(repository: OrderRepositoryProtocol, translator: OrderTranslator) {
        self.repository = repository
        self.translator = translator
    }
    
    func fetchOrders(_ id: String) -> Order {
        let entity = repository.fetchOrders(id)
        return translator.translate(entity)
    }
}

