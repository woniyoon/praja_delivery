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
        return Single<ProductEntity>.create { observer -> Disposable in
            self.db.collection(PRODUCT_COLLECTION)
                .document(productId)
                .getDocument { (document, error) in
                    if let error = error {
                        observer(.error(NomnomError.network(code: "", message: ErrorMsg.tryAgain, log: error.localizedDescription)))
                        return
                    }
                    guard let product = ProductEntity(docId: (document?.documentID)!, dictionary: (document?.data())!) else {
                        observer(.error(NomnomError.alert(message: "Parse Failure")))
                        return
                    }
                    observer(.success(product))
            }
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
