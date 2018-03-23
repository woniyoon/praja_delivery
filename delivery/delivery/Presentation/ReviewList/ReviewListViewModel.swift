//
//  ReviewListViewModel.swift
//  delivery
//
//  Created by Kento Uchida on 2018/03/23.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ReviewListViewModel: BaseViewModel {
    private let useCase: ReviewListUseCaseProtocol
    private let disposeBag: DisposeBag = DisposeBag()
    
    init(useCase: ReviewListUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func fetchReviewList(productId: String) {
        useCase.fetchReviewList(productId: productId)
            .subscribe(
                onSuccess: { model in },
                onError: { error in self.setError(error)}
        ).disposed(by: disposeBag)
    }
}
