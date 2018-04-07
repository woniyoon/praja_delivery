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
    // MARK: - BehaviorRelay
    // Overview
    var images = BehaviorRelay<[String]>(value: [])
    var name = BehaviorRelay(value: "")
    var price = BehaviorRelay(value: "")
    var originalPrice = BehaviorRelay(value: "")
    var discountRate = BehaviorRelay(value: "")
    
    // Review
    var reviewAverage = BehaviorRelay(value: 0.0)
    var reviewNum = BehaviorRelay(value: "(0)")
    
    var description = BehaviorRelay(value: "")
    
    var frequentlyPurchasedWith = BehaviorRelay<[Product]>(value: [])
    var relatedTo = BehaviorRelay<[Product]>(value: [])
    
    var numOfProduct = BehaviorRelay(value: 1)
    
    // MARK: - Private Properties
    private let useCase: ProductDetailUseCaseProtocol
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Initializer
    init(useCase: ProductDetailUseCaseProtocol) {
        self.useCase = useCase
    }
    
    // MARK: - Public Fuctions
    func fetchProductDetail(_ productId: String) {
        useCase.fetchProductDetail(productId)
            .subscribe(
                onSuccess: { model in self.setValues(of: model) },
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
    
    func addToCart() {
        // TODO Add to cart
        print("num is \(numOfProduct.value)")
    }

    // MARK: - Private Fuctions
    private func setValues(of model: Product) {
        self.images.accept(model.images)
        self.name.accept(model.name)
        self.price.accept(String(format: "$%0.2f", model.price))
        self.originalPrice.accept(String(format: "$%0.2f", model.originalPrice))
        if model.discountPercent == 0 {
            discountRate.accept("")
        } else {
            discountRate.accept("↓\(model.discountPercent)%")
        }
        
        // Review
        self.reviewAverage.accept(model.averageRating)
        
        self.description.accept(model.description)
    }
}
