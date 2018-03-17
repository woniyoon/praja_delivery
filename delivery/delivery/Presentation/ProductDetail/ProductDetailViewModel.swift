//
//  ProductDetailViewModel.swift
//  delivery
//
//  Created by Kento Uchida on 2018/03/05.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ProductDetailViewModel {
    
    var name = BehaviorRelay(value: "")
    var price = BehaviorRelay(value: "")
    var originalPrice = BehaviorRelay(value: "")
    var image = BehaviorRelay(value: "")
    
    private let useCase: ProductDetailUseCaseProtocol
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    init(useCase: ProductDetailUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func fetchProductDetail(_ id: String) {
        useCase.fetchProductDetail(id)
            .subscribe(
                onSuccess: { model in
                    self.name.accept(model.name)
                    self.price.accept("$\(model.price)")
                    self.originalPrice.accept("$\(model.originalPrice)")
            }) { error in
                print(error.localizedDescription)
        }.disposed(by: disposeBag)
    }
}
