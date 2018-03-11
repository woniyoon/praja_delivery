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
    
    init(useCase: ProductDetailUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func fetchProductDetail(_ id: String) {
        let model = useCase.fetchProductDetail(id)
        name.accept(model.name)
        price.accept("$\(model.price)")
        originalPrice.accept("$\(model.originalPrice)")
    }
}
