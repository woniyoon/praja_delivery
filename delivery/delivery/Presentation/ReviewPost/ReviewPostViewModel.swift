//
//  ReviewPostViewModel.swift
//  delivery
//
//  Created by Kento Uchida on 2018/05/11.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ReviewPostViewModel: BaseViewModel {
    
    var isComplete = BehaviorRelay<Bool>(value: false)
    
    private let useCase: ReviewPostUseCaseProtocol
    private let disposeBag: DisposeBag = DisposeBag()
    
    init(useCase: ReviewPostUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func postReivew(productId: String, rating: Double, title: String, comment: String) {
        useCase.postReivew(productId: productId, rating: rating, title: title, comment: comment)
            .subscribe(
                onCompleted: { self.isComplete.accept(true) },
                onError: { error in self.setError(error) }
        ).disposed(by: disposeBag)
    }
}

