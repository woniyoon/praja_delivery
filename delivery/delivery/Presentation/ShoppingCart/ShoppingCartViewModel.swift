//
//  ShoppingCartViewModel.swift
//  delivery
//
//  Created by Bacelar on 2018-04-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
import RxCocoa

class ShoppingCartViewModel: BaseViewModel {
    
    private var useCase: ShoppingCartUseCaseProtocol
    
    public var productsShoppingCart = BehaviorRelay<[ProductShoppingCart]>(value: [])
    private let disposeBag: DisposeBag = DisposeBag()
    
    init(useCase: ShoppingCartUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func fetchShoppingCartList(){
        
        useCase.fetchShoppingCart()
            .subscribe(
                onSuccess: { (product) in
                    print("View Model \(product.count)")
                    self.productsShoppingCart.accept(product)
            }, onError: { (error) in
                print(error.localizedDescription)}
            ) .disposed(by: disposeBag)
    }
        
}
