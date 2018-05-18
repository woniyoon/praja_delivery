//
//  HomeViewModel.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-03-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel: BaseViewModel {

// MARK: - Variables & Instances

    var arrOfTopSalesProduct = BehaviorRelay<[Product]>(value: [])
    var arrOfProductYouMayLike = BehaviorRelay<[Product]>(value: [])
    var arrOfNewProducts = BehaviorRelay<[Product]>(value: [])
    var arrOfTrendsKeyword = BehaviorRelay<[String]>(value: [])

    private let disposeBag: DisposeBag = DisposeBag()
    private let useCase: ProductListUseCaseProtocol
    private let useCaseShopping: ShoppingCartUseCaseProtocol

// MARK: - Init

    init(useCase: ProductListUseCaseProtocol, useCaseShopping: ShoppingCartUseCaseProtocol) {
        self.useCase = useCase
        self.useCaseShopping = useCaseShopping
        self.arrOfTrendsKeyword.accept(["Easter", "Chocolate", "Heinz", "Test", "Jaewon"])
    }

// MARK: - Methods

    func fetchTopSales() {
        useCase.fetchProductList(with: "", by: "name", false, filters: [String:Any]())
            .subscribe(onSuccess: { (product) in
            self.arrOfTopSalesProduct.accept(product)
            }
            , onError: { (err) in print(err) })
            .disposed(by: disposeBag)
    }
    
    func fetchProductYouMayLike() {
        useCase.fetchProductList(with: "", by: "name", true, filters: [String:Any]())
            .subscribe(onSuccess: { (product) in
                self.arrOfProductYouMayLike.accept(product)
            }
                , onError: { (err) in print(err) })
            .disposed(by: disposeBag)
    }
    
    func fetchNewProducts() {
        useCase.fetchProductList(with: "", by: "brand", false, filters: [String:Any]())
            .subscribe(onSuccess: { (product) in
                self.arrOfNewProducts.accept(product)
            }
                , onError: { (err) in print(err) })
            .disposed(by: disposeBag)
    }
}
