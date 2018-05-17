//
//  ReviewListFirebaseDataStore.swift
//  delivery
//
//  Created by Kento Uchida on 2018/03/23.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import Firebase
import RxSwift
import RxCocoa

class ReviewListFirebaseDataStore: ReviewListDataStoreProtocol {

    private let db = Firestore.firestore()
    
    func fetchReviewList(productId: String) -> Single<[ReviewEntity]> {
        let productRef = db.collection(PRODUCT_COLLECTION).document(productId)
        return Single<[ReviewEntity]>.create { observer -> Disposable in
            self.db.runTransaction({ (transaction, errorPointer) -> Any? in
                
                let productDoc: DocumentSnapshot
                do {
                    try productDoc = transaction.getDocument(productRef)
                } catch let fetchError as NSError {
                    errorPointer?.pointee = fetchError
                    return nil
                }
                let collection = productDoc.reference.collection("review")
                collection.addSnapshotListener({ (querySnapshot, error) in
                    guard let snapshot = querySnapshot else {
                        print("Error fetching snapshot results: \(error!)")
                        observer(.error(NomnomError.network(code: "", message: "Failed to rettrieve reviews", log: error.debugDescription)))
                        return
                    }
                    
                    let reviews = snapshot.documents
                        .map { ReviewEntity(dictionary: $0.data()) }
                        .filter { $0 != nil } as! [ReviewEntity]
                    observer(.success(reviews))
                })
                
                return nil
            }, completion: { (product, error) in })
            return Disposables.create()
        }
    }
}
