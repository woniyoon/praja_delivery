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
    private let useCase: HomeUseCaseProtocol

// MARK: - Init

    init(useCase: HomeUseCaseProtocol) {
        self.useCase = useCase
        self.arrOfTrendsKeyword.accept(["Easter", "Chocolate", "Heinz", "Test", "Jaewon"])
    }

// MARK: - Methods

    func fetchTopSales() {
        useCase.fetchTopSales()
                .subscribe(
                    onSuccess: { model in
                            self.arrOfTopSalesProduct.accept(model)
                    },
                        onError: { error in print(error) }
                    )
                    .disposed(by: disposeBag)
    }
    
    func fetchProductYouMayLike() {
        useCase.fetchProductYouMayLike()
            .subscribe(
                onSuccess: { model in
                    self.arrOfProductYouMayLike.accept(model)
            },
                onError: { error in print(error) }
            )
            .disposed(by: disposeBag)
    }
    
    func fetchNewProducts() {
        useCase.fetchNewProducts()
            .subscribe(
                onSuccess: { model in
                    self.arrOfNewProducts.accept(model)
            },
                onError: { error in print(error) }
            )
            .disposed(by: disposeBag)
    }
}
