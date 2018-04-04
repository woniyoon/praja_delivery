//
//  HomeFirebaseDataStore.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-03-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import Firebase
import RxSwift

class HomeFirebaseDataStore: HomeDataStoreProtocol {
    let db = Firestore.firestore()
    
    func fetchTopSales() -> Single<[ProductEntity]> {
        var arr = [ProductEntity]()
        return Single<[ProductEntity]>.create { observer -> Disposable in
            self.db.collection("product").getDocuments { (documents, error) in
                if let error = error {
                    observer(.error(error))
                    return
                }
                if let docs = documents?.documents {
                    for doc in docs {
                        let product = ProductEntity(docId: doc.documentID, dictionary: (doc.data()))
                        arr.append(product!)
                    }
                }
                observer(.success(arr))
            }
            return Disposables.create()
        }
    }
    
    func fetchProductYouMayLike() -> Single<[ProductEntity]> {
        var arr = [ProductEntity]()
        return Single<[ProductEntity]>.create { observer -> Disposable in
            self.db.collection("product").getDocuments { (documents, error) in
                if let error = error {
                    observer(.error(error))
                    return
                }
                if let docs = documents?.documents {
                    for doc in docs {
                        let product = ProductEntity(docId: doc.documentID, dictionary: (doc.data()))
                        arr.append(product!)
                    }
                }
                observer(.success(arr))
            }
            return Disposables.create()
        }
    }
    
    func fetchNewProducts() -> Single<[ProductEntity]> {
        var arr = [ProductEntity]()
        return Single<[ProductEntity]>.create { observer -> Disposable in
            self.db.collection("product").getDocuments { (documents, error) in
                if let error = error {
                    observer(.error(error))
                    return
                }
                if let docs = documents?.documents {
                    for doc in docs {
                        let product = ProductEntity(docId: doc.documentID, dictionary: (doc.data()))
                        arr.append(product!)
                    }
                }
                observer(.success(arr))
            }
            return Disposables.create()
        }
    }
}
