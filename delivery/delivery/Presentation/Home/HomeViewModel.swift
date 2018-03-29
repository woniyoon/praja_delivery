//
//  HomeViewModel.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-03-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel: BaseViewModel {
    
    var name = BehaviorRelay(value: "")
    var price = BehaviorRelay(value: "")
    var originalPrice = BehaviorRelay(value: "")
    
    var arr = BehaviorRelay<[Product]>(value: [])
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    private let useCase: HomeUseCaseProtocol

    init(useCase: HomeUseCaseProtocol) {
        self.useCase = useCase
    }

  
//    func fetchProducts() {
//        useCase.fetchProducts()
//            .subscribe(
//                onSuccess: { model in
//                    self.name.accept(model.name)
//                    self.price.accept("$\(model.price)")
//                    self.originalPrice.accept("$\(model.originalPrice)") },
//                onError: { error in
//                    print(error.localizedDescription) }
//            )
//            .disposed(by: disposeBag)
//    }
    
    func fetchArrayOfProduct() {
        useCase.fetchArrayOfProduct()
                    .subscribe(
                        onSuccess: { model in
                            self.arr.accept(model)
                           
                    },
                        onError: { error in print(error) }
                    )
                    .disposed(by: disposeBag)
    }
}
