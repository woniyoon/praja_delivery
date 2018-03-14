//
//  OrderUseCase.swift
//  delivery
//
//  Created by MATSUHISA MAI on 2018/03/12.
//  Copyright © 2018年 CICCC. All rights reserved.
//

import Foundation

protocol OrderUseCaseProtocol {
    func fetchOrder(_ id: String) -> OrderModel
}

class OrderUseCase: OrderUseCaseProtocol {
    
    internal let repository: OrderRepositoryProtocol
    internal let translator: OrderTranslator
    
    init(repository: OrderRepositoryProtocol, translator: OrderTranslator) {
        self.repository = repository
        self.translator = translator
    }
    
    func fetchOrder(_ id: String) -> OrderModel {
        let entity = repository.fetchOrder(id)
        return translator.translate(entity)
    }
}
