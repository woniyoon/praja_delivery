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
    
    public var subTotal = BehaviorRelay<String>(value: "0.0")
    public var productsShoppingCart = BehaviorRelay<[ProductShoppingCart]>(value: [])
    private let disposeBag: DisposeBag = DisposeBag()
    
    init(useCase: ShoppingCartUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func fetchShoppingCartList(){
        
       useCase.fetchShoppingCart()
            .subscribe(
                onSuccess: { (product) in
                    print("View Model has \(product.count) product")
                    var arr = product
                    arr = arr + self.productsShoppingCart.value
                    self.productsShoppingCart.accept(arr)
                    let shoppingCart = self.productsShoppingCart.value
                    
                    var preSubTotal = 0.0
                    
                    for item in shoppingCart {
                        preSubTotal = preSubTotal + item.total
                    }
                    self.subTotal.accept("$ \(String(format:"%.2f", preSubTotal))")
            }, onError: { (error) in
                print(error.localizedDescription)}
            ) .disposed(by: disposeBag)
        
    }
        
}
