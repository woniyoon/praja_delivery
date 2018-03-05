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

protocol ProductDetailViewModelProtocol{
    func fetchProductDetail(_ id: String)
}

class ProductDetailViewModel {
    
    private var nameVariable = Variable<String>("")
    private var priceVariable = Variable<String>("")
    private var originalPriceVariable = Variable<String>("")
    private var imageVariable = Variable<String>("")
    
    func name() -> Observable<String> {
        return self.nameVariable.asObservable()
    }
    
    func price() -> Observable<String> {
        return self.priceVariable.asObservable()
    }
    
    func originalPrice() -> Observable<String> {
        return self.originalPriceVariable.asObservable()
    }
    
    func image() -> Observable<String> {
        return self.imageVariable.asObservable()
    }
    
    func setSampleData() {
        nameVariable.value = "Sour Patch Kids Sweet and Sour Gummy Candy (Strawberry, 10 Ounce Bag, Pack of 12)"
        priceVariable.value = "$13.87"
        originalPriceVariable.value = "$15.00"
    }
    
    //    init(useCase: ProductListUseCaseProtocol) {
    //        self.useCase = useCase
    //    }
    
    private let useCase: ProductDetailUseCaseProtocol? = nil
}

extension ProductDetailViewModel: ProductDetailViewModelProtocol {

    func fetchProductDetail(_ id: String) {
        
    }
}
