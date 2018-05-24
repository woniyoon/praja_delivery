//
//  OrderUseCase.swift
//  delivery
//
//  Created by MATSUHISA MAI on 2018/03/12.
//  Copyright © 2018年 CICCC. All rights reserved.
//

import Foundation
import RxSwift

protocol OrderUseCaseProtocol {
    func fetchOrder(_ id: String) -> Single<Order>
    func saveOrder(_ order: Order) -> Completable
}

class OrderUseCase: OrderUseCaseProtocol {
    
    internal let repository: OrderRepositoryProtocol
    internal let translator: OrderTranslator
    
    init(repository: OrderRepositoryProtocol, translator: OrderTranslator) {
        self.repository = repository
        self.translator = translator
    }
    
    func fetchOrder(_ id: String) -> Single<Order> {
        return repository.fetchOrder(id)
            .map({ entity in
                self.translator.translate(entity)
            })
    }
    
    func saveOrder(_ order: Order) -> Completable {
        return repository.saveOrder(translator.translateToEntity(order))
    }
    
}
