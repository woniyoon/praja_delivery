//
//  ProductDetailFirebaseDataStore.swift
//  delivery
//
//  Created by Kento Uchida on 2018/02/24.
//  Copyright © 2018 CICCC. All rights reserved.
//
import Foundation
import Firebase
import RxSwift

class ProductDetailFirebaseDataStore: ProductDetailDataStoreProtocol {
    
    private let db = Firestore.firestore()
    
    func fetchProductDetail(_ productId: String) -> Single<ProductEntity> {
        let productRef = db.collection(PRODUCT_COLLECTION).document(productId)
        print("========= fetch")
        return Single<ProductEntity>.create { observer -> Disposable in
            print("========= single")
            self.db.runTransaction({ (transaction, errorPointer) -> Any? in
                
                print("========= transaction")
                let productDoc: DocumentSnapshot
                do {
                    try productDoc = transaction.getDocument(productRef)
                } catch let fetchError as NSError {
                    errorPointer?.pointee = fetchError
                    return nil
                }
                guard var product = ProductEntity(docId: productDoc.documentID, dictionary: productDoc.data()!) else {
                    observer(.error(NomnomError.alert(message: "Parse Failure")))
                    return nil
                }
                let collection = productDoc.reference.collection("review")
                collection.addSnapshotListener({ (querySnapshot, error) in
                    print("========= snapshot")
                    guard let snapshot = querySnapshot else {
                        print("Error fetching snapshot results: \(error!)")
                        observer(.success(product))
                        return
                    }
                    
//                    var reviews: [ReviewEntity] = []
//                    for reviewDict in snapshot.documents as [Any] {
//                        let review = ReviewEntity(dictionary: (reviewDict as? [String : Any])!)
//                        if let review = review {
//                            reviews.append(review)
//                        }
//                    }
                    let reviews = snapshot.documents
                        .map { ReviewEntity(dictionary: $0.data()) }
                        .filter { $0 != nil } as! [ReviewEntity]
                    product.reviews = reviews
                    observer(.success(product))
                })
                
                print("========= DONE")
                return nil
            }, completion: { (product, error) in
                print("hey")
                print("yo")
            })
//            self.db.collection(PRODUCT_COLLECTION)
//                .document(productId)
//                .getDocument { (document, error) in
//                    if let error = error {
//                        observer(.error(NomnomError.network(code: "", message: ErrorMsg.tryAgain, log: error.localizedDescription)))
//                        return
//                    }
//                    guard let product = ProductEntity(docId: (document?.documentID)!, dictionary: (document?.data())!) else {
//                        observer(.error(NomnomError.alert(message: "Parse Failure")))
//                        return
//                    }
//                    observer(.success(product))
//            }
            return Disposables.create()
        }
    }
    
    func fetchFrequentlyPurchasedWith(_ productId: String) -> Single<[ProductEntity]> {
        return Single<[ProductEntity]>.create { observer -> Disposable in
            self.db.collection(PRODUCT_COLLECTION).limit(to: 5).getDocuments { (documents, error) in
                if let error = error {
                    observer(.error(error))
                    return
                }
                guard let docs = documents?.documents else {
                    observer(.error(NomnomError.alert(message: "Failed to get data")))
                    return
                }
                
                var products: [ProductEntity] = []
                for doc in docs {
                    if let product = ProductEntity(docId: doc.documentID, dictionary: (doc.data())) {
                        products.append(product)
                    }
                }
                observer(.success(products))
            }
            return Disposables.create()
        }
    }
    
    func fetchRelatedTo(_ productId: String) -> Single<[ProductEntity]> {
        return Single<[ProductEntity]>.create { observer -> Disposable in
            self.db.collection(PRODUCT_COLLECTION).limit(to: 4).getDocuments { (documents, error) in
                if let error = error {
                    observer(.error(error))
                    return
                }
                guard let docs = documents?.documents else {
                    observer(.error(NomnomError.alert(message: "Failed to get data")))
                    return
                }
                
                var products: [ProductEntity] = []
                for doc in docs {
                    if let product = ProductEntity(docId: doc.documentID, dictionary: (doc.data())) {
                        products.append(product)
                    }
                }
                observer(.success(products))
            }
            return Disposables.create()
        }
    }
}
