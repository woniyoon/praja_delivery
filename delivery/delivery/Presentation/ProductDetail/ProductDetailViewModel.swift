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
    
    private let useCase: ProductDetailUseCaseProtocol
    private let disposeBag: DisposeBag = DisposeBag()
    
    init(useCase: ProductDetailUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func fetchProductDetail(_ id: String) {
        useCase.fetchProductDetail(id)
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
}
