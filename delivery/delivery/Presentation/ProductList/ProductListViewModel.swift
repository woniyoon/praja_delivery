//
//  ProductListViewModel.swift
//  delivery
//
//  Created by Bacelar on 2018-03-13.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ProductListViewModel {
//    var name = BehaviorRelay(value: "")
//    var price = BehaviorRelay(value: "")
//    var oldPrice = BehaviorRelay(value: "")
    
    private var useCase: ProductListUseCaseProtocol
        
    init(useCase: ProductListUseCaseProtocol ) {
        self.useCase = useCase
    }

    
    func fetchProductList()->[SampleProductModel]{
        return useCase.fetchProductList()
    }
    
    func fetchProductCount() -> Int {
       return useCase.fetchProductList().count
    }
}
