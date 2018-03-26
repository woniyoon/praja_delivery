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
    var products = BehaviorRelay(value: [Product]())
    private let disposeBag: DisposeBag = DisposeBag()
    
    init(useCase: ProductListUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func fetchProductList(){
        useCase.fetchProductList()
            .subscribe(
                onSuccess: { (product) in
                self.products.accept(product)
            }, onError: { (error) in
                print(error.localizedDescription)}
            ) .disposed(by: disposeBag)
    }
    
}
