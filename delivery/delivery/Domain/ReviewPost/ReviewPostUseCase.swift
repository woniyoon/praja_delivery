//
//  ReviewPostUseCase.swift
//  delivery
//
//  Created by Kento Uchida on 2018/05/11.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ReviewPostUseCaseProtocol {
    func postReivew(productId: String, rating: Double, title: String?, comment: String?) -> Completable
}

class ReviewPostUseCase: ReviewPostUseCaseProtocol {
    private let repository: ReviewPostRepositoryProtocol
    
    init(repository: ReviewPostRepositoryProtocol) {
        self.repository = repository
    }
    
    func postReivew(productId: String, rating: Double, title: String?, comment: String?) -> Completable {
        guard rating != 0, let title = title, !title.isEmpty, let comment = comment, !comment.isEmpty else {
            return Completable.error(NomnomError.alert(message: "Please input properly"))
        }
        return repository.postReivew(productId: productId, rating: rating, title: title, comment: comment)
    }
}
