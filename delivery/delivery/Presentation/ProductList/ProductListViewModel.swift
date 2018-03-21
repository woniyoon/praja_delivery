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

class ProductListViewModel: NSObject {

    private var useCase: ProductListUseCaseProtocol
    let productList = Variable<[SampleProductModel]>([])
    
    init(useCase: ProductListUseCaseProtocol ) {
        self.useCase = useCase
        productList.value = useCase.fetchProductList()
    }
    
}
