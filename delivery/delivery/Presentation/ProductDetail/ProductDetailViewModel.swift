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

class ProductDetailViewModel : BaseViewModel {
    
    var images = BehaviorRelay<[String]>(value: [])
    var name = BehaviorRelay(value: "")
    var price = BehaviorRelay(value: "")
    var originalPrice = BehaviorRelay(value: "")
    
    // Review
    var reviewAverage = BehaviorRelay(value: 0.0)
    
    var description = BehaviorRelay(value: "")
    
    var frequentlyPurchasedWith = BehaviorRelay<[Product]>(value: [])
    var relatedTo = BehaviorRelay<[Product]>(value: [])
    
    var numOfProduct = BehaviorRelay(value: 1)
    
    private let useCase: ProductDetailUseCaseProtocol
    private let disposeBag: DisposeBag = DisposeBag()
    
    init(useCase: ProductDetailUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func fetchProductDetail(_ productId: String) {
        useCase.fetchProductDetail(productId)
            .subscribe(
                onSuccess: { model in
                    self.images.accept(model.images)
                    self.name.accept(model.name)
                    self.price.accept(String(format: "$%0.2f", model.price))
                    self.originalPrice.accept(String(format: "$%0.2f", model.originalPrice))
                    
                    // Review
                    self.reviewAverage.accept(model.averageRating)
                    
                    self.description.accept(model.description) },
                onError: { error in self.setError(error) }
            ).disposed(by: disposeBag)
    }
    
    func fetchFrequentlyPurchasedWith(_ productId: String) {
        useCase.fetchFrequentlyPurchasedWith(productId)
            .subscribe(
                onSuccess: { models in
                    self.frequentlyPurchasedWith.accept(models) },
                onError: { error in self.setError(error) }
            ).disposed(by: disposeBag)
    }
    
    func fetchRelatedTo(_ productId: String) {
        useCase.fetchRelatedTo(productId)
            .subscribe(
                onSuccess: { models in
                    self.relatedTo.accept(models) },
                onError: { error in self.setError(error) }
            ).disposed(by: disposeBag)
    }
    
    func changeNumOfProduct(isIncrement: Bool) {
        if isIncrement {
            if numOfProduct.value >= 99 { return }
            numOfProduct.accept(numOfProduct.value + 1)
        } else {
            if numOfProduct.value <= 1 { return }
            numOfProduct.accept(numOfProduct.value - 1)
        }
    }
}
