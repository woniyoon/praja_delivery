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
import RxDataSources

class OrderViewModel : BaseViewModel{
    public var arrOfOrder = BehaviorRelay<[SectionModel<String, Order>]>(value: [])
    
    private var useCase: OrderUseCaseProtocol
    private let disposeBag: DisposeBag = DisposeBag()
    
    init(useCase: OrderUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func fetchOrder(with userId: String) {
        useCase.fetchOrder(with: userId)
            .subscribe(
                onSuccess: { model in
                    var currentOrder: [Order] = []
                    var pastOrder: [Order] = []
                    model.forEach({ (order) in
                        if (order.deliveryInfo["deliveredDate"] == nil) {
                            currentOrder.append(order)
                        } else {
                            pastOrder.append(order)
                        }
                    })
                    self.arrOfOrder.accept([
                        SectionModel(model: "Current Order", items:currentOrder),
                        SectionModel(model: "Past Order", items: pastOrder)])
            }, onError: { (error) in
                print(error.localizedDescription)}
            ).disposed(by: disposeBag)
    }
}
