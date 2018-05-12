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
        return Completable.create { observer -> Disposable in
            
            return Disposables.create()
        }
    }
}
