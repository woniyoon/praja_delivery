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
                    self.arrOfOrder.accept([
                        SectionModel(model: "Current Order", items:model),
                        SectionModel(model: "Past Order", items: model)])
            }, onError: { (error) in
                print(error.localizedDescription)}
            ).disposed(by: disposeBag)
    }
}
