//
//  OrderViewModel.swift
//  delivery
//
//  Created by MATSUHISA MAI on 2018/03/12.
//  Copyright © 2018年 CICCC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class OrderViewModel {
    
    var name = BehaviorRelay(value: "")
    var price = BehaviorRelay(value: "")
    var originalPrice = BehaviorRelay(value: "")
    var image = BehaviorRelay(value: "")
    
    private let useCase: OrderUseCaseProtocol
    
    init(useCase: OrderUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func fetchOrder(_ id: String) {
        let model = useCase.fetchOrder(id)
        name.accept(model.name)
        price.accept("$\(model.price)")
        originalPrice.accept("$\(model.originalPrice)")
    }
}
