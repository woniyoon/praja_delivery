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
    public var qtyProductsCart = BehaviorRelay<String>(value: "")
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
        fetchShoppingCartQty()
    }
    
    func fetchShoppingCart() -> Single<[ProductShoppingCart]> {
        return useCaseShopping.fetchShoppingCart()
    }

    func fetchShoppingCartQty() {
        useCaseShopping.fetchShoppingCart().subscribe(onSuccess: { (product) in
            self.qtyProductsCart.accept(String(product.count))
            print("\(product.count) in cart")
        }, onError: { (err) in
            print(err)
        })
    }

    
    func productAlreadyInCart(with primaryKey: String)-> Bool {
        var result = false
        let realm = try! Realm()
        let shoppingCartExist = realm.objects(ShoppingCartEntity.self).filter("idProducts = '\(primaryKey)'")
        if shoppingCartExist.first != nil {
            result = true
        }
        return result
    }
    
}
