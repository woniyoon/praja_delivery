//
//  ProductListViewModel.swift
//  delivery
//
//  Created by Bacelar on 2018-03-13.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
import RxCocoa

class ProductListViewModel: BaseViewModel {
    
    private var useCase: ProductListUseCaseProtocol
    private var useCaseShopping: ShoppingCartUseCaseProtocol
    
    public var productsList = BehaviorRelay<[Product]>(value: [])
    private let disposeBag: DisposeBag = DisposeBag()
    
    init(useCase: ProductListUseCaseProtocol, useCaseShopping: ShoppingCartUseCaseProtocol) {
        self.useCase = useCase
        self.useCaseShopping = useCaseShopping
    }
    
    func fetchProductList(with keyword:String){
        useCase.fetchProductList(with: keyword)
            .subscribe(
                onSuccess: { (product) in
                self.productsList.accept(product)
            }, onError: { (error) in
                print(error.localizedDescription)}
            ) .disposed(by: disposeBag)
    }
    
    func addProductShoppingCart(with shoppingCart: ShoppingCart){
        useCaseShopping.addProductShoppingCart(shoppingCart: shoppingCart)
        
    }
    
    func fetchShoppingCart() -> Single<[ProductShoppingCart]> {
        
        return useCaseShopping.fetchShoppingCart()
    }
    
    func productAlreadyInCart(with primaryKey: String)-> Bool {
        var result = false
        let realm = try! Realm()
        let shoppingCartExist = realm.object(ofType: ShoppingCartEntity.self, forPrimaryKey: primaryKey)
        if shoppingCartExist != nil {
            result = true
        }
        return result
    }
    
}
