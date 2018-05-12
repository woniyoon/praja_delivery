//
//  ReviewPostFirebaseDataStore.swift
//  delivery
//
//  Created by Kento Uchida on 2018/05/11.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

import Firebase
import RxSwift
import RxCocoa

class ReviewPostFirebaseDataStore: ReviewPostDataStoreProtocol {
    
    private let db = Firestore.firestore()
    
    func postReview(productId: String, rating: Double, title: String, comment: String) -> Completable {
        guard let user = Auth.auth().currentUser else {
            return Completable.error(NomnomError.alert(message: "You need to sign in"))
        }
        let review = ReviewEntity(comment: comment, rating: rating, title: title, userId: user.uid, userName: user.displayName!)
        
        return Completable.create { observer -> Disposable in
            self.db.collection(PRODUCT_COLLECTION)
                .document(productId)
                .collection(REVIEW_COLLECTION)
                .addDocument(data: review.dictionary) { error in
                    if let error = error {
                        observer(.error(error))
                    } else {
                        observer(.completed)
                    }
                }
            return Disposables.create()
        }
    }
}
