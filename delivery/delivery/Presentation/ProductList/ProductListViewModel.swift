//
//  ProductListViewModel.swift
//  delivery
//
//  Created by Bacelar on 2018-03-13.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

import Foundation
import RxSwift
import RxCocoa

class ProductListViewModel {
    
    var productName = BehaviorRelay(value: "")
    
    private let useCase: ProductListUseCaseProtocol
    
    init(useCase: ProductListUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func fetchProductList() {
        let model = useCase.fetchProductList()
        productName.accept("Bruno")
    }
}
