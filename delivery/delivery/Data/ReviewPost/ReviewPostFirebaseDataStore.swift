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
    
    func fetchReview(productId: String) -> Single<ReviewEntity> {
        guard let user = Auth.auth().currentUser else {
            return Single.error(NomnomError.alert(message: "Please sign in"))
        }
        return Single.create(subscribe: { observer in
            self.db.collection(PRODUCT_COLLECTION)
                .document(productId)
                .collection(REVIEW_COLLECTION)
                .whereField("userId", isEqualTo: user.uid)
                .getDocuments(completion: { (snapshot, error) in
                    if let error = error {
                        observer(.error(error))
                    } else {
                        guard let doc = snapshot?.documents, doc.count > 0 else {
                            observer(.error(NomnomError.noData(message: "NO DATA")))
                            return
                        }
                        guard let review = ReviewEntity(dictionary: doc[0].data()) else {
                            observer(.error(NomnomError.alert(message: "Parse Failure")))
                            return
                        }
                        observer(.success(review))
                    }
                })
            return Disposables.create()
        })
    }
    
    func postReview(productId: String, userName: String, rating: Double, title: String, comment: String) -> Completable {
        guard let user = Auth.auth().currentUser else {
            return Completable.error(NomnomError.alert(message: "You need to sign in"))
        }
        let review = ReviewEntity(comment: comment, rating: rating, title: title, userId: user.uid, userName: userName)
        
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
