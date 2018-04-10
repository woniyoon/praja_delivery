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
    var reviewList = BehaviorRelay<[Review]>(value: [])
    
    private let useCase: ReviewListUseCaseProtocol
    private let disposeBag: DisposeBag = DisposeBag()
    
    init(useCase: ReviewListUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func fetchReviewList(productId: String) {
        reviewList.accept([
            Review(userId: "123", userName: "Kento Uchida", title: "Hello", comment: "No – one gets an iron – clad guarantee of success. Certainly, factors like opportunity, luck and timing are important. But the backbone of success is usually found in old – fashioned, basic concepts like hard work, determination, good planning and perseverance.", rating: 3.4, productId: "aaa", date: Date.init()),
            Review(userId: "123", userName: "Kento Uchida", title: "Short one", comment: "It's really short comment!", rating: 3.4, productId: "aaa", date: Date.init())])
//        useCase.fetchReviewList(productId: productId)
//            .subscribe(
//                onSuccess: { model in },
//                onError: { error in self.setError(error)}
//        ).disposed(by: disposeBag)
    }
}
